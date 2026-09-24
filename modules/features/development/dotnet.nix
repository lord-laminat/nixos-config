{
  flake.modules.homeManager.dotnet = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ dotnet-sdk_10 ];
  };
}
