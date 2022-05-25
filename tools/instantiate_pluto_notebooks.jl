import Pkg

should_update = true
should_instantiate = true
should_precompile = true
should_install_IJulia = true

if !haskey(Pkg.installed(),"Pluto")
    Pkg.activate(mktempdir());
    Pkg.add([
      Pkg.PackageSpec(name="Pluto", version="0.19.5"),
      ])
    if should_precompile
       Pkg.precompile()
    end
    using Pluto
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
        #println(joinpath(root, file)) # path to files
        if contains(file, ".git")
           continue
        end
        if endswith(file, ".jl")
            file_with_path = joinpath(root, file)
            open(file_with_path, "r") do io
                firstline = String(readline(io))
                if firstline == Pluto._notebook_header
                    println("# Found a Pluto.jl notebook: ", file_with_path)
                    println("# Activating ", file_with_path)
                    Pluto.activate_notebook_environment(file_with_path)
                    if should_update
                        println("# Updating ", file_with_path)
                        Pkg.update()
                    end
                    if should_instantiate
                        println("# Instantiating ", file_with_path)
                        Pkg.instantiate()
                    end
                    if should_precompile
                       println("# Precompiling packages used by ", file_with_path)
                       Pkg.precompile()
                    end
                end # is Pluto notebook
            end # open file
        end  # if .jl
    end # for file
end


if should_install_IJulia  && !haskey(Pkg.installed(),"IJulia")
    println("# Installing IJulia")
    Pkg.activate(mktempdir());
    Pkg.add([
      Pkg.PackageSpec(name="IJulia"),
      ])
    if should_precompile
       Pkg.precompile()
    end
    using IJulia
end


