# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  system,
  ...
}: {
  options = {
    largePrograms.enable = lib.mkEnableOption "enables largePrograms";
  };

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
  };

  # You can import other home-manager modules here
  imports = [
    ./programs
    ./shell
  ];

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      experimental-features = "nix-command flakes";
    };
  };

  home.username = "carlo";
  home.homeDirectory = "/home/carlo";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}