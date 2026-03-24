{
  pkgs,
  inputs,
  ...
}: let
  # Wrap Zen browser with a policies.json that force-installs uBlock Origin.
  # Zen is Firefox-based so enterprise policies work the same way.
  # The xpi is fetched from AMO on first launch (requires internet).
  policiesJson = pkgs.writeText "zen-policies.json" (builtins.toJSON {
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
    };
  });

  zenWithExtensions = inputs.zen-browser.packages.${pkgs.system}.default.overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + ''
        mkdir -p $out/lib/zen/distribution
        cp ${policiesJson} $out/lib/zen/distribution/policies.json
      '';
  });
in {
  home.packages = [zenWithExtensions];
}
