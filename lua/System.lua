-- first off, some helper functions:
--
-- size of sector
local function sos (nSectors)
	return math.pi * 2 / nSectors
end
--
-- transform from Radius and Angle
local function tfraa (R, A)
	return mat4.Rotation (vec3.z, A) ^ mat4.Movement (R * vec3.x) 
end
--
-- rotation of Ring
local function ror (R, turn)
	return (R.A * turn) % (2 * math.pi)
end
--
-- angle of Sector center
local function aosc (S, turn)
	return (S.B + S.parent.A * (turn + 0.5)) % (2 * math.pi)
end
--
-- width of Ring
local function wor (R)
	return 0.5 * (R.R2 - R.R1)
end
--
-- radius of Ring center
local function rorc (R)
	return wor (R) + R.R1
end
--
-- scale of embedded system
local function soes (ring)
	return 0.9 * wor (ring)
end

-- is a given Angle inside a sector of given Size with center at zero?
local function closeEnough (a, s)
	-- angle might be > 2 PI, negative, obtuse
	-- so normalize it to [-PI, PI]
    a = (a + math.pi) % (2 * math.pi) - math.pi
	-- delta is necessary
	return s - math.abs (a) > 0.001
end

-- do two sectors intersect?
local function intersection (S1, S2, turn)
	-- sectors intersect if the difference between the angles
	-- is less than sum of half-angular sizes
    local a = aosc (S1, turn) - aosc (S2, turn)
    local s = (S1.parent.A + S2.parent.A) / 2
    return closeEnough (a, s)
end

-- does a sector intersect the left/right semicircle?
local function halfIntersection (S, half, turn)
	-- see above
	local c = half and math.pi / 2 or -math.pi / 2
    local a = aosc (S, turn) - c
	local s = (S.parent.A + math.pi) / 2
    return closeEnough (a, s)
end

local function totalSize (options)
    local total = options.radius
    for r, orbit in ipairs (options.orbits) do
        total = total + orbit.width
    end
    return total
end

function NewSystem (options, world)
	S = {
		colour = options.colour,
		radius = options.radius,
	}
	local scale
    if options.external then
        local ring = options.external.ring
        local dist = rorc (ring)
        local phi = aosc (ring[options.external[1]], 0)
        if options.external[2] then
            local phi2 = aosc (ring[options.external[2]], 0)
            phi = (phi + phi2) / 2
        end
        S.rMat = tfraa (dist, phi)
        S.parent = ring
		scale = soes (ring)
    else
        S.rMat = mat4.id
        S.parent = world.center
        scale = 1
    end

    scale = scale / totalSize (options)
    S.rings = {}

    -- Generate the rings and sectors inside rings
    local R1 = S.radius
    for r, orbit in ipairs (options.orbits) do
        local R2 = R1 + orbit.width
        local ring = {
            A = sos (orbit.nSectors),
            parent = S,
            R1 = R1 * scale,
            R2 = R2 * scale,
        }
        S.rings[r - 1] = ring

        for i = 0, orbit.nSectors - 1 do
            ring[i] = {
                parent = ring,
				-- just to add some variation
                colour = vec3 (0, 0, ring.A * i % 0.689 + 0.3),
                B = ring.A * i,
            }
        end

        R1 = R2
    end

    S.radius = S.radius * scale

    -- Add ring-neighbour links
    for _, ring in zpairs (S.rings) do
        for i, R in zpairs (ring) do
            -- h, i, j
            local len = #ring + 1
            local h = (i - 1) % len
            local j = (i + 1) % len
            R.links = {[ring[h]]=true, [ring[j]]=true}
        end
    end

    -- Add conditional inter-ring links
    for r = 1, #S.rings do
        local ring = S.rings[r]
        local prev = S.rings[r - 1]
        for _, R in zpairs (ring) do
            for _, P in zpairs (prev) do
                local F = function (turn)
                    return intersection (R, P, turn)
                end
                R.links[P] = F
                P.links[R] = F
            end
        end
    end

    -- External links
    if options.external then
		local ring = options.external.ring
        local O1 = ring[options.external[1]]
        local O2 = ring[options.external[2]]
		if not O2 then
			for _, R in zpairs (S.rings[#S.rings]) do
				R.links[O1] = true
				O1.links[R] = true
			end
		else
			for _, R in zpairs (S.rings[#S.rings]) do
				local F1 = function (turn)
					return halfIntersection (R, false, turn)
				end
				local F2 = function (turn)
					return halfIntersection (R, true, turn)
				end
				R.links[O1] = F1
				O1.links[R] = F1
				R.links[O2] = F2
				O2.links[R] = F2
			end
		end
    end

    -- phony circle
    local phony = {
        parent = S.parent,
		rMat = S.rMat,
        colour = -colour.white,
		radius = S.radius
    }

    -- Finally, inject it all into the world
    table.insert (world.nodes, phony)
    table.insert (world.circles, 1, phony)
    table.insert (world.systems, 1, S)
    table.insert (world.nodes, S)
    table.insert (world.spheres, S)
    for _, ring in zpairs (S.rings) do
        table.insert (world.nodes, ring)
        for _, sector in zpairs (ring) do
            -- reverse order in world.sectors
            table.insert (world.sectors, 1, sector)
        end
        table.insert (world.rings, ring)
    end
	return S
end

function GetHovered ()
	for _, S in ipairs (World.systems) do
		local hovered = HoveredInSystem (S)
		if hovered ~= nil then return hovered end
	end
end

function HoveredInSystem (S)
    local function Y (angle) return angle % (2 * math.pi) < math.pi end
    V = mat4.Inverse (S.tMat) % Lock
    R = vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    if R < S.radius then
        return false
    end
    for _, ring in zpairs (S.rings) do
        if ring.R1 < R and R < ring.R2 then
            for _, sector in zpairs (ring) do
                local y1 = A - sector.B - ring.phi
                local y2 = sector.B + ring.phi + ring.A - A
                if Y (y1) and Y (y2) then
					return sector
                end
            end
        end
    end
end

function UpdateRing (R)
    R.phi = ror (R, world.turn.float)
    R.rMat = mat4.Rotation (vec3.z, R.phi)
end
