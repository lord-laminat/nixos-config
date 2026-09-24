{
  description = "rychkin's NixOS and standalone Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    inir = {
      url = "github:snowarch/iNiR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    happ-nix = {
      url = "github:DaHL-gh/happ-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.modules
        ./modules/flake/configurations.nix
        ./modules/flake/checks.nix
        ./modules/flake/devshell.nix
        ./modules/features/system/networking.nix
        ./modules/features/system/bluetooth.nix
        ./modules/features/system/locale.nix
        ./modules/features/system/utilities.nix
        ./modules/features/desktop/ly.nix
        ./modules/features/desktop/niri.nix
        ./modules/features/desktop/terminal.nix
        ./modules/features/applications/firefox.nix
        ./modules/features/applications/happ.nix
        ./modules/features/applications/codex.nix
        ./modules/features/applications/obsidian.nix
        ./modules/features/applications/ayugram.nix
        ./modules/features/applications/libreoffice.nix
        ./modules/features/development/vscode.nix
        ./modules/features/development/zed.nix
        ./modules/features/development/neovim.nix
        ./modules/features/development/dotnet.nix
        ./modules/features/development/python.nix
        ./modules/features/development/c-cpp.nix
        ./modules/features/development/tools.nix
        ./modules/features/services/docker.nix
        ./modules/features/services/virtualbox.nix
        ./modules/features/development/aflplusplus.nix
        ./modules/features/system/nix.nix
        ./modules/users/rychkin/default.nix
        ./modules/users/rychkin/laptop.nix
        ./modules/hosts/laptop/default.nix
        ./modules/hosts/laptop/hardware.nix
      ];
      systems = [ "x86_64-linux" ];
    };
}
