{
  flake.modules.nixos.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "/etc/ly/result.dur";
        dur_offset_alignment = "center";
        dur_x_offset = 90;
        dur_y_offset = 18;
        animation_timeout_sec = 0;
        full_color = true;
      };
    };
    environment.etc."ly/result.dur".source = ../../../assets/ly/result.dur;
  };
}
