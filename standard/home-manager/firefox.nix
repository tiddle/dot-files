{
  pkgs,
  config,
  lib,
  ...
}:  {

  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extensions = lib.mkIf config.programs.firefox.enable
      (with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ]);
      settings = {
        "beacon.enabled" = false;
        "browser.contentblocking.category" = "strict";
        "browser.display.background_color" = "#c5c8c6";
        "browser.display.foreground_color" = "#1d1f21";
        "browser.download.dir" = "/home/carlo/Download";
        "browser.safebrowsing.appRepURL" = "";
        "browser.safebrowsing.malware.enabled" = false;
        "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter";
        "browser.search.suggest.enabled" = false;
        "browser.send_pings" = false;

        "browser.startup.page" = 3;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.uidensity" = 1; # Dense.
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.speculativeConnect.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = false;
        "dom.security.https_only_mode" = true;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "extensions.pocket.enabled" = false;
        "general.smoothScroll" = false;
        "geo.enabled" = false;
        "gfx.webrender.all" = true;
        "layout.css.devPixelsPerPx" = "1";
        "media.navigator.enabled" = false;
        "media.video_stats.enabled" = false;
        "network.IDN_show_punycode" = true;
        "network.allow-experiments" = false;
        "network.dns.disablePrefetch" = true;
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.trimmingPolicy" = 1;
        "network.prefetch-next" = false;
        "permissions.default.shortcuts" = 2; # Don't steal my shortcuts!
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.firstparty.isolate" = true;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.content.gtk-theme-override" = "Adwaita:light";
      };
    };
  };
}