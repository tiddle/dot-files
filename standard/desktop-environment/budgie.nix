
# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.displayManager.lightdm.enable = true;


  environment.budgie.excludePackages = with pkgs; [
    mate.mate-terminal
    vlc
  ];
}