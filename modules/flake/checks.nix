{ config, ... }:
{
  perSystem = { pkgs, system, ... }: {
    formatter = pkgs.nixfmt;
    checks = pkgs.lib.optionalAttrs (system == "x86_64-linux") {
      system = config.flake.nixosConfigurations.laptop.config.system.build.toplevel;
      home = config.flake.homeConfigurations."rychkin@laptop".activationPackage;
    };
  };
}
