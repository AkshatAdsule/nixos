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

    xdg-desktop-portal
    xdg-desktop-portal-gtk

    # Wine
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
  ];
}
