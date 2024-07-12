path = "/vortexfs1/home/anthony.meza/scratch/proj2"
Pkg.activate(path)
Pkg.add("CUDA")
Pkg.add("Oceananigans")

Pkg.instantiate()
using CUDA, Test
CUDA.versioninfo()
N = 2^20
x_d = CUDA.fill(1.0f0, N)
y_d = CUDA.fill(2.0f0, N)
y_d .+= x_d
@test all(Array(y_d) .== 3.0f0)
print(y_d)
println("Successful CUDA Test")

using Oceananigans
grid = RectilinearGrid(GPU(), size=(128, 128), x=(0, 2π), y=(0, 2π), topology=(Periodic, Periodic, Flat))
model = NonhydrostaticModel(; grid, advection=WENO())
ϵ(x, y) = 2rand() - 1
set!(model, u=ϵ, v=ϵ)
simulation = Simulation(model; Δt=0.01, stop_time=4)
run!(simulation)

println("Successful Oceananigans Test")
