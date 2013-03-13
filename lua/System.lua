function NewSystem (this, world)
    table.insert (world.systems, this)
    this.segments = {}
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / orbit.nCells
        for i = 1, orbit.nCells do
            local segment = {
                parent = this,
                colour = vec3.Random (true),
                R1 = R1,
                R2 = R2,
                A = A,
                phi = A * (i - 1),
            }
            table.insert (world.segments, segment)
            table.insert (this.segments, segment)
        end
        R1 = R2
    end
end

function System (this)
    if KeyDown (KEY.P1) and world.camera.lock then
        V = world.camera.lock
        R = vec3.Length (V) 
        A = math.atan2 (V.e.y, V.e.x)
        if A < 0 then A = A + 2 * math.pi end
        for _,s in ipairs (this.segments) do
            if A > s.phi and A < s.phi + s.A and
                    s.R1 < R and R < s.R2 then
                s.colour = vec3.Random (true)
            end
        end
    end
end
