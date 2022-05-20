if ! haskey(Pkg.installed(),"PlutoSliderServer")
        import Pkg;
        Pkg.activate(mktempdir());
        Pkg.add([
                Pkg.PackageSpec(name="PlutoSliderServer", version="0.3.2-0.3"),
              ])
end

import PlutoSliderServer
PlutoSliderServer.github_action(".";
        #Export_cache_dir="pluto_state_cache",
        Export_baked_notebookfile=false,
        Export_baked_state=false,
        # more parameters can go here
      )
