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
  boot.loader.grub.enable = true;
  # CHECK BEFORE INSTALL: set to your actual disk (e.g. /dev/sda, /dev/nvme0n1)
  # Current value "/dev/vda" is for VMs only
  boot.loader.grub.device = "/dev/vda";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Desktop environment — uncomment one:
    # ../desktop-environment/budgie.nix
    ../desktop-environment/plasma6.nix
    # ../desktop-environment/xfce.nix
    # ../desktop-environment/pantheon.nix

    # CHECK BEFORE INSTALL: comment this out in VMs or non-NVIDIA systems
    ../hardware/nvidia.nix
    inputs.xremap-flake.nixosModules.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  services.xremap = {
    userName = "carlo";
    config = {
      keymap = [
        {
          name = "Standard";
          remap = {
            CapsLock = "Ctrl_L";
          };
        }
      ];
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
    };
    channel.enable = false;

    # Garbage collect weekly — keeps /nix/store from growing unbounded
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # NFS client
  services.rpcbind.enable = true;

  environment.systemPackages = with pkgs.unstable; [
    vim
    git
  ];

  programs.zsh.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # KDE Connect — opens required firewall ports automatically
  programs.kdeconnect.enable = true;

  # XDG desktop portals (screen share, file picker, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  };

  # Flatpak
  # After first install, add Flathub remote manually:
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = true;

  # Docker
  # After first install, log out and back in for docker group membership to take effect
  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  programs.mangohud.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  networking.hostName = "carlo-pc";

  users.users = {
    carlo = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "gamemode" "docker"];
    };
  };

  services.xserver.xkbOptions = "caps:ctrl_modifier";
  console.useXkbConfig = true;

  users.defaultUserShell = pkgs.zsh;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}