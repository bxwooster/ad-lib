local function CloseEnough (s, d)
    local x = d % (2 * math.pi)
    local y = math.pi * 2 - x
    local delta = 0.001
    return s - x > delta or s - y > delta
end

local function Intersection (R, P, turn)
    local r, p = R.parent.A / 2, P.parent.A / 2
    local d = (R.B + R.parent.A * turn + r) - (P.B + P.parent.A * turn + p)
    local s = r + p
    return CloseEnough (s, d)
end

local function HalfIntersection (R, half, turn)
    local r = R.parent.A / 2
    local d = (R.B + R.parent.A * turn + r) + math.pi / 2
    if half then d = d + math.pi end
    local s = r + math.pi / 2
    return CloseEnough (s, d)
end

local function Scaling (this)
    local total = this.radius
    for r, orbit in ipairs (this.orbits) do
        total = total + orbit.width
    end
    return this.scale / total
end

function NewSystem (this, world)
    if this.external then
        local ring = this.external.parent
        local size = 0.5 * (ring.R2 - ring.R1)
        local dist = size + ring.R1
        local phi = ring.A * 0.5 + this.external.B
        if this.external2 then
            local phi2 = ring.A * 0.5 + this.external2.B
            phi = (phi + phi2) / 2
        end
        local dir = vec3.New (math.cos (phi), math.sin (phi), 0)
        this.rMat = mat4.Movement (dist * dir) ^ mat4.Rotation (vec3.z, ring.A)
        this.scale = 0.9 * size
        this.parent = ring
    else
        this.scale = 1
        this.rMat = mat4.id
        this.parent = world.center
    end

    local scale = Scaling (this)
    local rings = {}
    this.rings = rings

    -- Generate the rings and segments inside rings
    local R1 = this.radius
    for r, orbit in ipairs (this.orbits) do
        local A = math.pi * 2 / orbit.nCells
        local R2 = R1 + orbit.width

        local ring = {
            A = A,
            parent = this,
            R1 = R1 * scale,
            R2 = R2 * scale,
        }
        rings[r - 1] = ring

        for i = 0, orbit.nCells - 1 do
            ring[i] = {
                parent = ring,
                colour = vec3.New (0, 0, A * i % 0.5 + 0.5),
                B = A * i,
            }
        end

        R1 = R2
    end

    this.radius = this.radius * scale

    -- Add ring-neighbour links
    for _, ring in zpairs (rings) do
        for i, R in zpairs (ring) do
            -- h, i, j
            local len = #ring + 1
            local h = (i - 1) % len
            local j = (i + 1) % len
            R.links = {[ring[h]]=true, [ring[j]]=true}
        end
    end

    -- Add conditional inter-ring links
    for r = 1, #rings do
        local ring = rings[r]
        local prev = rings[r - 1]
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
    if this.external2 then
        local O1 = this.external
        local O2 = this.external2
        for _, R in zpairs (rings[#rings]) do
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
    elseif this.external then
        local O = this.external
        for _, R in zpairs (rings[#rings]) do
            R.links[O] = true
            O.links[R] = true
        end
    end

    -- phony segment
    this.R1 = 0
    this.R2 = this.radius
    this.A = 2 * math.pi
    local phony = {
        parent = this,
        colour = -colour.white,
        B = 0
    }
    table.insert (world.segments, 1, phony)

    -- Finally, inject it all into the world
    table.insert (world.systems, this)
    table.insert (world.nodes, this)
    table.insert (world.spheres, this)
    for _, ring in zpairs (rings) do
        table.insert (world.nodes, ring)
        for _, segment in zpairs (ring) do
            -- reverse order in world.segments
            table.insert (world.segments, 1, segment)
        end
        table.insert (world.rings, ring)
    end
end

function HoverInSystem (this)
    if Hovered == false then return end
    local function X (angle) return angle % (2 * math.pi) end
    local function Y (angle) return X (angle) < math.pi end
    V = mat4.Inverse (this.tMat) % Lock
    R = vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    if R < this.radius then
        Hovered = false
        return
    end
    for _, ring in zpairs (this.rings) do
        if ring.R1 < R and R < ring.R2 then
            for _, segment in zpairs (ring) do
                local y1 = A - segment.B - ring.phi
                local y2 = segment.B + ring.phi + ring.A - A
                if Y (y1) and Y (y2) then
                    Hovered = segment
                end
            end
        end
    end
end

function DrawSegment (this)
    local colour = Selected[this] or this.colour
    core.Segment (this.parent.tMat, colour,
        this.parent.R1, this.parent.R2, this.parent.A, this.B)
end

function UpdateRing (this)
    this.phi = (this.A * World.turn.float) % (2 * math.pi)
    this.rMat = mat4.Rotation(vec3.z, this.phi)
end
