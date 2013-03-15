local function Intersection (R, P, turn)
    local r, p = R.A / 2, P.A / 2
    local d = (R.B + R.A * turn + r) - (P.B + P.A * turn + p)
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
        local ring = {A = A, parent = this}
        rings[r - 1] = ring

        local R2 = R1 + orbit.width

        for i = 0, orbit.nCells - 1 do
            ring[i] = {
                parent = ring,
                colour = Vec3.New (0, 0, A * i % 0.5 + 0.5),
                R1 = R1 / RTotal,
                R2 = R2 / RTotal,
                A = A,
                B = A * i,
            }
        end

        R1 = R2
    end

    this.radius = this.radius / RTotal

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
    for r = 0, #rings do
        local ring = rings[r]
        table.insert (world.nodes, ring)
        for i = 0, #ring do
            -- reverse order in world.segments
            table.insert (world.segments, 1, ring[i])
        end
    end
end

function UpdateSystem (this)
    for r = 0, #this.rings do
        local ring = this.rings[r]
        ring.phi = (ring.A * World.turn.float) % (2 * math.pi)
        ring.rMat = Mat4.Rotation(Vec3.z, ring.A * World.turn.float)
    end
end

function SelectSystem (this)
    local function X (angle) return angle % (2 * math.pi) end
    local function Y (angle) return X (angle) < math.pi end
    V = Mat4.Inverse (this.tMat) % Lock
    R = Vec3.Length (V) 
    A = math.atan2 (V.e.y, V.e.x)
    if A < 0 then A = A + 2 * math.pi end
    for _,s in ipairs (this.segments) do
        if Y (A - s.B - s.parent.phi) and Y (s.B + s.parent.phi + s.A - A) and s.R1 < R and R < s.R2 then
            Selected[s] = Colour.black
            if KeyDown (KEY.P1) then
                Start = s
                Path = nil
            elseif KeyDown (KEY.P2) then
                End = s
                Path = nil
            end
            for n, f in pairs (s.links) do
                if f == true or f (World.turn.int) then
                    Selected[n] = Colour.magenta
                end
            end
        end
    end
end

function Segment (this)
    local colour = Selected[this] or this.colour
    Core.Segment (this.parent.tMat, colour,
        this.R1, this.R2, this.A, this.B)
end

local function Reconstruct (cameFrom, current)
    if not cameFrom[current] then return {current} end
    local list = Reconstruct (cameFrom, cameFrom[current])
    table.insert (list, current)
    return list
end

function AStar (start, end_)
    local closed = {}
    local open = {[start]=true}
    local cameFrom = {}
    local gScore = {[start]=0}

    while next (open) do
        local g = 777
        local C
        for v in pairs (open) do
            if gScore [v] < g then
                g = gScore [v]
                C = v
            end
        end
        if C == end_ then return Reconstruct (cameFrom, end_) end
        open[C] = nil
        closed[C] = true

        for N, F in pairs (C.links) do
            if F == true or F (World.turn.int + gScore[C]) then
                local tentative = gScore[C] + 1
                if not closed[N] or tentative < gScore[N] then
                    if not open[N] or tentative < gScore[N] then
                        cameFrom[N] = C
                        gScore[N] = tentative
                        open[N]=true
                    end
                end
            end
        end
    end

    return {}
end

