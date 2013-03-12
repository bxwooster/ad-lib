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
                phi = A * i,
            }
            table.insert (world.segments, segment)
            table.insert (this.segments, segment)
        end
        R1 = R2
    end
end

function System (this)
    if world.camera.lock then
        if vec3.Length (world.camera.lock) < 1 then
            print ("Hit!")
        end
    end
end
