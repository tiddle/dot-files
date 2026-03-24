{ ... }: {
  # Force KDE Plasma 6 into dark mode (Breeze Dark colour scheme)
  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=BreezeDark

    [KDE]
    LookAndFeelPackage=org.kde.breezedark.desktop
  '';

  xdg.configFile."kwinrc".text = ''
    [org.kde.kdecoration2]
    theme=__aurorae__svg__BreezeLight
    ColorScheme=BreezeDark
  '';
}
