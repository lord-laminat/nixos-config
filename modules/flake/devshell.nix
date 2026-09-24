{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = [
        pkgs.git
        pkgs.nixfmt
      ];
    };
  };
}
