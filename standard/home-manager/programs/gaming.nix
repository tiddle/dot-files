{ pkgs, ... }: {
  # AIDEV-NOTE: System-level gaming (Steam, GameMode, MangoHud, ProtonGE) lives
  # in nixos/configuration.nix. This module handles per-user gaming packages.
  home.packages = with pkgs; [
    bottles       # Wine prefix manager for running Windows games/apps
  ];
}
