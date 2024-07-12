path = "/vortexfs1/home/anthony.meza/OceananigansOnPoseidon"
using Pkg
Pkg.activate(path)
Pkg.add("CUDA")
Pkg.instantiate()

using CUDA, Test
CUDA.versioninfo()
N = 2^20
x_d = CUDA.fill(1.0f0, N)
y_d = CUDA.fill(2.0f0, N)
y_d .+= x_d
@test all(Array(y_d) .== 3.0f0)
println("Successful CUDA Test")