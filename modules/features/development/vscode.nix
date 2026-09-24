{
  flake.modules.homeManager.vscode = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ vscode ];
  };
}
