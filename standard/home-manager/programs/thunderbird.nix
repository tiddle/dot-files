{pkgs, lib, config, ...}: {
  programs.thunderbird = lib.mkIf config.largePrograms.enable {
    enable = true;
  };
}