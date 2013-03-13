function NewSystem (this, world)
    -- Generate the segments inside rings
    local rings = {}
    local R1 = this.radius
    for r, orbit in ipairs (this.orbits) do
        local ring = {}
        rings[r - 1] = ring

        local R2 = R1 + orbit.width
        local A = math.pi * 2 / orbit.nCells

        for i = 0, orbit.nCells - 1 do
            ring[i] = {
                parent = this,
                colour = Vec3.Random (true),
                R1 = R1,
                R2 = R2,
                A = A,
                B = A * i,
            }
        end

        R1 = R2
    end

    -- Add ring-neighbour links
    for r = 0, #rings do
        local ring = rings[r]
        for i = 0, #ring do
            -- h, i, j
            local h = (i - 1) % (#ring + 1)
            local j = (i + 1) % (#ring + 1)
            ring[i].links = {[ring[h]]=true, [ring[j]]=true}
        end
    end

    -- Add conditional inter-ring links
    for r = 1, #rings do
        local ring = rings[r]
        local prev = rings[r - 1]
        for i = 0, #ring do
            local R = ring[i]
            for k = 0, #prev do
                local P = prev[k]

                local F = function () return Time % 1 < 0.5 end
                R.links[P] = F
                P.links[R] = F
            end
        end
    end

    -- Finally, inject it all into the world
    table.insert (world.systems, this)
    this.segments = {}
    for r = 0, #rings do
        local ring = rings[r]
        for i = 0, #ring do
            table.insert (world.segments, ring[i])
            table.insert (this.segments, ring[i])
        end
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
