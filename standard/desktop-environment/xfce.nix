{
  # if you use pulseaudio
  nixpkgs.config.pulseaudio = true;
  services.xserver.desktopManager.xfce.enable;
} 