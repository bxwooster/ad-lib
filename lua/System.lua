function NewSystem (this, world)
    table.insert (world.systems, this)
    this.segments = {}
    local R1 = this.radius
    local prevring
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
                B = A * i,
            }
            ring[i] = segment
            table.insert (world.segments, segment)
            table.insert (this.segments, segment)
        end
        for i = 0, #ring do
            -- h, i, j
            local h = (i - 1) % N
            local j = (i + 1) % N
            ring[i].links = {[ring[h]]=true, [ring[j]]=true}
            local R = ring[i]
            local F = function () return Time % 1 < 0.5 end
            if prevring then
                for k = 0, #prevring do
                    local P = prevring[k]
                    R.links[P] = F
                    P.links[R] = F
                end
            end
        end
        R1 = R2
        prevring = ring
    end
end

function System (this)
    local function X (angle) return angle % (2 * math.pi) end
    local function Y (angle) return X (angle) < math.pi end
    for _,s in ipairs (this.segments) do
        s.phi = (s.B + s.A * World.turn.float) % (2 * math.pi)
    end

    V = Mat4.Inverse (this.tMat) % Lock
    R = Vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    for _,s in ipairs (this.segments) do
        if Y (A - s.phi) and Y (s.phi + s.A - A) and s.R1 < R and R < s.R2 then
            Selected[s] = Colour.white
            for n,f in pairs (s.links) do
                if f == true or f () then
                    Selected[n] = Colour.black
                end
            end
        end
    end
end

function Segment (this)
    local colour = Selected[this] or this.colour
    Core.Segment (this.parent.tMat, colour,
        this.R1, this.R2, this.A, this.phi)
end
