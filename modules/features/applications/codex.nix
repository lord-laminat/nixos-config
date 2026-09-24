{
  flake.modules.nixos.codex = { pkgs, ... }: {
    environment.systemPackages = [ (pkgs.callPackage ../../../packages/codex/package.nix { }) ];
  };
}
