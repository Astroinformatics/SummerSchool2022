using Pluto, Pkg

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
                    println("# File ",file_with_path, " is a Pluto.jl notebook")
                    println("# Activating ", file_with_path)
                    Pluto.activate_notebook_environment(joinpath(root, file))
                    println("# Updating ", file_with_path)
                    Pkg.update()
                    println("# Instantiating ", file_with_path)
                    Pkg.instantiate()
                end
            end
        end  # if .jl
    end # for file
end
