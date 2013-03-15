local function Intersection (R, P, turn)
    local r, p = R.parent.A / 2, P.parent.A / 2
    local d = (R.B + R.parent.A * turn + r) - (P.B + P.parent.A * turn + p)
    local s = r + p
    local x = d % (2 * math.pi)
    local y = math.pi * 2 - x
    local delta = 0.1
    return s - x > delta or s - y > delta
end

function NewSystem (this, world)
    -- Generate the segments inside rings
    local rings = {}

    local RTotal = this.radius
    for r, orbit in ipairs (this.orbits) do
        RTotal = RTotal + orbit.width
    end
    RTotal = RTotal / this.scale

    local R1 = this.radius
    for r, orbit in ipairs (this.orbits) do
        local A = math.pi * 2 / orbit.nCells
        local R2 = R1 + orbit.width

        local ring = {
            A = A,
            parent = this,
            R1 = R1 / RTotal,
            R2 = R2 / RTotal,
        }
        rings[r - 1] = ring

        for i = 0, orbit.nCells - 1 do
            ring[i] = {
                parent = ring,
                colour = Vec3.New (0, 0, A * i % 0.5 + 0.5),
                B = A * i,
            }
        end

        R1 = R2
    end

    this.radius = this.radius / RTotal

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

    -- Finally, inject it all into the world
    table.insert (world.systems, this)
    table.insert (world.nodes, this)
    table.insert (world.spheres, this)
    this.rings = rings
    this.segments = {}
    for _, ring in zpairs (rings) do
        table.insert (world.nodes, ring)
        for _, segment in zpairs (ring) do
            -- reverse order in world.segments
            table.insert (world.segments, 1, segment)
        end
        table.insert (world.rings, ring)
    end
end

function System (this)
    local function X (angle) return angle % (2 * math.pi) end
    local function Y (angle) return X (angle) < math.pi end
    V = Mat4.Inverse (this.tMat) % Lock
    R = Vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    for _, ring in zpairs (this.rings) do
        for _, segment in zpairs (ring) do
            if Y (A - segment.B - ring.phi) and Y (segment.B + ring.phi + ring.A - A) and ring.R1 < R and R < ring.R2 then
                Selected[segment] = Colour.black
                if KeyDown (KEY.P1) then
                    if not Start then
                        Start = segment
                    elseif not End then
                        End = segment
                    else
                        Start = nil
                        End = nil
                        Path = nil
                    end
                end
                for link, f in pairs (segment.links) do
                    if f == true or f (World.turn.int) then
                        Selected[link] = Colour.magenta
                    end
                end
            end
        end
    end
end

function Segment (this)
    local colour = Selected[this] or this.colour
    Core.Segment (this.parent.tMat, colour,
        this.parent.R1, this.parent.R2, this.parent.A, this.B)
end

function Ring (this)
    this.phi = (this.A * World.turn.float) % (2 * math.pi)
    this.rMat = Mat4.Rotation(Vec3.z, this.phi)
end
