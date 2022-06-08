import Pkg
Pkg.activate(mktempdir())
Pkg.add([
        Pkg.PackageSpec(name="CUDA", version="3"),
        Pkg.PackageSpec(name="Flux", version="0.13"),
        Pkg.PackageSpec(name="BenchmarkTools", version="1"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
Pkg.instantiate()

using CUDA, Flux

x_h = rand(128)
x_d = cu(x_h)
x_d2 = x_h |> gpu
