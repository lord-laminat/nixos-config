{
  flake.modules.nixos.stm32 = { pkgs, ... }: {
    services.udev.packages = with pkgs; [
      openocd
    ];

    users.users.rychkin.extraGroups = [ "dialout" "plugdev" ];
  };

  flake.modules.homeManager.stm32 = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      stm32cubemx
      ( lib.lowPrio gcc-arm-embedded )
      cmake
      ninja
      openocd
    ];
  };
} 