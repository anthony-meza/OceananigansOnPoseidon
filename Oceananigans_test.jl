path = "/vortexfs1/home/anthony.meza/OceananigansOnPoseidon"
using Pkg
Pkg.activate(path)
Pkg.add("Oceananigans")
Pkg.instantiate()

using Oceananigans, Test
grid = RectilinearGrid(GPU(), size=(128, 128), x=(0, 2π), y=(0, 2π), topology=(Periodic, Periodic, Flat))
model = NonhydrostaticModel(; grid, advection=WENO())
ϵ(x, y) = 2rand() - 1
set!(model, u=ϵ, v=ϵ)
simulation = Simulation(model; Δt=0.01, stop_time=4)
run!(simulation)

println("Successful Oceananigans Test")
