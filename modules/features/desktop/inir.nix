{ inputs, ... }:
{
  flake.modules.nixos.inir = { config, pkgs, ... }: {
    imports = [ inputs.inir.nixosModules.inir ];
    programs.inir = {
      enable = true;
      # The upstream launcher uses set -e; absent optional variables must succeed.
      package =
        (pkgs.callPackage (inputs.inir + "/nix/package.nix") { inherit pkgs; }).overrideAttrs
          (old: {
            patches = (old.patches or [ ]) ++ [ ../../../packages/inir/environment.patch ];
            # Keep helpers available for manual launches as well as the service.
            postFixup = (old.postFixup or "") + ''
              wrapProgram "$out/bin/inir" \
                --prefix PATH : "${pkgs.lib.makeBinPath config.programs.inir.extraPackages}"
            '';
          });
      service.compositor = "niri";
      extraPackages = [
        config.programs.niri.package
        pkgs.swayidle
        pkgs.libsecret
        pkgs.matugen
        pkgs.awww
        pkgs.gowall
        pkgs.which
        pkgs.go
      ];
    };
    # Helpers must also be available to login shells started by iNiR.
    environment.systemPackages = config.programs.inir.extraPackages ++ [ pkgs.lxqt.lxqt-policykit ];
  };

  flake.modules.homeManager.inir = { config, lib, ... }: {
    programs.ghostty.settings = lib.mkIf config.programs.ghostty.enable {
      theme = "ii-auto";
    };
    xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
      include "inir.kdl"
    '';
    xdg.configFile."niri/inir.kdl".source = ../../../assets/niri/inir.kdl;
  };
}
