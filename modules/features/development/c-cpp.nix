{
  flake.modules.homeManager.c-cpp = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      (lib.hiPrio gcc)
      (lib.lowPrio llvmPackages.clang)
      gnumake
      cmake
      ninja
      meson
      pkg-config
      gdb
      llvmPackages.lldb
    ];
  };
}
