{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use the proprietary driver (better performance/compatibility)
    open = false;

    # Enable modesetting — required for Wayland and fixes screen tearing
    modesetting.enable = true;

    # Expose nvidia-settings for GPU tweaking
    nvidiaSettings = true;

    # Pin to stable. Other options: beta, production, legacy_470 etc.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Power management — safe default for desktops
    powerManagement.enable = false;
  };
}
