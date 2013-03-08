function Sphere (this)
    core.Sphere (this.tmat, this.radius)
end

function Transform (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end
