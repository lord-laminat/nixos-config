{
  flake.modules.homeManager.python = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ python3 ];
  };
  perSystem = { pkgs, ... }: {
    devShells.python312 = pkgs.mkShellNoCC { packages = [ pkgs.python312 ]; };
  };
}
