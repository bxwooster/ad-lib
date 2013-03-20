-- is a given angle inside a sector of given size with center at zero?
local function CloseEnough (a, s)
	-- angle might be > 2 PI, negative, obtuse
	-- so normalize it to [-PI, PI]
    a = (a + math.pi) % (2 * math.pi) - math.pi
	-- delta is necessary
	return s - math.abs (a) > 0.001
end

-- do two sectors intersect?
local function Intersection (S1, S2, turn)
	-- half angular size
    local h1 = S1.parent.A / 2
	local h2 = S2.parent.A / 2
	-- angle where the sector center is
    local c1 = S1.B + S1.parent.A * turn + h1
	local c2 = S2.B + S2.parent.A * turn + h2
	-- sectors intersect if the difference between the angles
	-- is less than sum of half-angular sizes
    local s = h1 + h2
	local a = c1 - c2
    return CloseEnough (a, s)
end

-- does a sector intersect the left/right semicircle?
local function HalfIntersection (S, half, turn)
	-- see Intersecton
    local h1 = S.parent.A / 2
	local h2 = math.pi / 2
    local c1 = S.B + S.parent.A * turn + h1
	local c2 = half and math.pi / 2 or -math.pi / 2
    local s = h1 + h2
	local a = c1 - c2
    return CloseEnough (a, s)
end

local function TotalSize (options)
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
        local ring = options.external.parent
        local size = 0.5 * (ring.R2 - ring.R1)
        local dist = size + ring.R1
        local phi = ring.A / 2 + options.external.B
        if options.external2 then
            local phi2 = ring.A / 2 + options.external2.B
            phi = (phi + phi2) / 2
        end
        local dir = vec3.New (math.cos (phi), math.sin (phi), 0)
        S.rMat = mat4.Movement (dist * dir) ^ mat4.Rotation (vec3.z, ring.A)
        S.parent = ring
        scale = 0.9 * size
    else
        S.rMat = mat4.id
        S.parent = world.center
        scale = 1
    end

    scale = scale / TotalSize (options)
    S.rings = {}

    -- Generate the rings and sectors inside rings
    local R1 = S.radius
    for r, orbit in ipairs (options.orbits) do
        local A = math.pi * 2 / orbit.nCells
        local R2 = R1 + orbit.width

        local ring = {
            A = A,
            parent = S,
            R1 = R1 * scale,
            R2 = R2 * scale,
        }
        S.rings[r - 1] = ring

        for i = 0, orbit.nCells - 1 do
            ring[i] = {
                parent = ring,
                colour = vec3.New (0, 0, A * i % 0.689 + 0.3),
                B = A * i,
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
                    return Intersection (R, P, turn)
                end
                R.links[P] = F
                P.links[R] = F
            end
        end
    end

    -- External links
    if options.external2 then
        local O1 = options.external
        local O2 = options.external2
        for _, R in zpairs (S.rings[#S.rings]) do
            local F1 = function (turn)
                return HalfIntersection (R, false, turn)
            end
            local F2 = function (turn)
                return HalfIntersection (R, true, turn)
            end
            R.links[O1] = F1
            O1.links[R] = F1
            R.links[O2] = F2
            O2.links[R] = F2
        end
    elseif options.external then
        local O = options.external
        for _, R in zpairs (S.rings[#S.rings]) do
            R.links[O] = true
            O.links[R] = true
        end
    end

    -- phony sector
    S.R1 = 0
    S.R2 = S.radius
    S.A = 2 * math.pi
    local phony = {
        parent = S,
        colour = -colour.white,
        B = 0
    }

    -- Finally, inject it all into the world
    table.insert (world.sectors, 1, phony)
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
	return false
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
    R.phi = (R.A * World.turn.float) % (2 * math.pi)
    R.rMat = mat4.Rotation (vec3.z, R.phi)
end
