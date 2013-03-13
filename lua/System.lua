function NewSystem (this, world)
    table.insert (world.systems, this)
    this.segments = {}
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / orbit.nCells
        local ring = {}
        local N = orbit.nCells
        for i = 0, N - 1 do
            local segment = {
                parent = this,
                colour = Vec3.Random (true),
                R1 = R1,
                R2 = R2,
                A = A,
                B = A * (i - 1),
            }
            ring[i] = segment
            table.insert (world.segments, segment)
            table.insert (this.segments, segment)
        end
        for i = 0, N - 1 do
            -- h, i, j
            local h = (i - 1) % N
            local j = (i + 1) % N
            ring[i].neighbours = {ring[h], ring[j]}
        end
        R1 = R2
    end
end

function System (this)
    local function X (angle) return angle % (2 * math.pi) end
    local function Y (angle) return X (angle) < math.pi end
    for _,s in ipairs (this.segments) do
        s.phi = s.B + s.A * World.turn.float
    end

    V = Mat4.Inverse (this.tMat) % Lock
    R = Vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    for _,s in ipairs (this.segments) do
        if Y (A - s.phi) and Y (s.phi + s.A - A) and s.R1 < R and R < s.R2 then
            Selected[s] = Colour.white
            for _,n in ipairs (s.neighbours) do
                Selected[n] = Colour.black
            end
        end
    end
end

function Segment (this)
    local colour = Selected[this] or this.colour
    Core.Segment (this.parent.tMat, colour,
        this.R1, this.R2, this.A, this.phi)
end

