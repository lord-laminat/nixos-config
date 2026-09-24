{
  flake.modules.homeManager.aflplusplus = { pkgs, ... }: {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "aflplusplus";
        runtimeInputs = [ pkgs.docker ];
        text = ''
          exec docker run --rm -it --mount "type=bind,src=$PWD,dst=/src" --workdir /src "''${AFLPLUSPLUS_IMAGE:-aflplusplus/aflplusplus:latest}" "$@"
        '';
      })
    ];
  };
}
