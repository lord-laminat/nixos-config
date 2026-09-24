{ config, inputs, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [ config.flake.modules.nixos.laptop ];
  };

  # Independent activation: no Home Manager module is imported into NixOS.
  flake.homeConfigurations."rychkin@laptop" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = (
      import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }
    );
    modules = [ config.flake.modules.homeManager.rychkin-laptop ];
  };
}
