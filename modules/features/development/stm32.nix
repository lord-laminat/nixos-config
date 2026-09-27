{
  flake.modules.nixos.stm32 = { pkgs, ... }: {
    services.udev.packages = with pkgs; [
      openocd
    ];

    users.users.rychkin.extraGroups = [ "dialout" "plugdev" ]
  };

  flake.modules.homeManager.stm32 = { pkgs, ... }: {
    home.packages = with pkgs; [
      stm32cubemx
      gcc-arm-embedded
      cmake
      ninja
      openocd
    ];
  };
} 