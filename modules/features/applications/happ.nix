{ inputs, ... }: {
  flake.modules.nixos.happ = { pkgs, ... }: {
    imports = [ inputs.happ-nix.nixosModules.default ];
    programs.happ = {
      enable = true;
      tunMode.enable = true;
      package = import ../../../packages/happ/package.nix {
        inherit pkgs;
        lib = pkgs.lib;
      };
    };
  };
}
