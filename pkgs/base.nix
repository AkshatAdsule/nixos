{
  config,
  pkgs,
  inputs,
  ...
}:
# Basic system packages to install across all systems
{
  environment.systemPackages = with pkgs; [
    google-chrome
    bitwarden-desktop
    btop
    killall
    fprintd
    wl-clipboard
    zip
    spotify

    # Wine
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
  ];
}
