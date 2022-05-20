if ! (haskey(Pkg.installed(),"PlutoSliderServer") &&  haskey(Pkg.installed(),"Pluto") )
        Pkg.activate(mktempdir());
        Pkg.add([
          Pkg.PackageSpec(name="Pluto", version="0.19.5"),
          Pkg.PackageSpec(name="PlutoSliderServer", version="0.3.2-0.3"),
          ])
    end


import PlutoSliderServer
#=
PlutoSliderServer.github_action(".";
#Export_cache_dir="pluto_state_cache",
Export_baked_notebookfile=false,
Export_baked_state=false,
# more parameters can go here
)
=#

using Pluto


for (root, dirs, files) in walkdir(".")
    for file in files
        println(joinpath(root, file)) # path to files
        if endswith(file, ".jl")
           file_with_path = joinpath(root, file)
           open(file_with_path, "r") do io
               firstline = String(readline(io))
                if firstline == Pluto._notebook_header
                  PlutoSliderServer.export_notebook(file_with_path)
                 end
          end # open
         end  # if .jl
    end # for file
end
