{
  flake.modules.nixos.virtualbox = {
    virtualisation.virtualbox.host.enable = true;
    users.users.rychkin.extraGroups = [ "vboxusers" ];
  };
}
