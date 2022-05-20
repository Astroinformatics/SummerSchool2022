import Pkg

should_update = true
should_instantiate = true

if ! haskey(Pkg.installed(),"Pluto")
    Pkg.activate(mktempdir());
    Pkg.add([
      Pkg.PackageSpec(name="Pluto", version="0.19.5"),
      ])
end

using Pluto

for (root, dirs, files) in walkdir(".")
    #=
    println("Directories in $root")
    for dir in dirs
        println(joinpath(root, dir)) # path to directories
    end
    =#
    #println("Files in $root")
    for file in files
        println(joinpath(root, file)) # path to files
        if endswith(file, ".jl")
            file_with_path = joinpath(root, file)
            open(file_with_path, "r") do io
                firstline = String(readline(io))
                if firstline == Pluto._notebook_header
                    println("# Found a Pluto.jl notebook: ", file_with_path)
                    println("# Activating ", file_with_path)
                    Pluto.activate_notebook_environment(file_with_path)
                    println("# Updating ", file_with_path)
                    if should_update
                        Pkg.update()
                    end
                    println("# Instantiating ", file_with_path)
                    if should_instantiate
                        Pkg.instantiate()
                    end
                end
            end
        end  # if .jl
    end # for file
end
