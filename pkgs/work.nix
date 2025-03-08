{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    zoom-us
    slack
    obsidian
    todoist-electron
    discord
    firefoxpwa
    firefox-devedition-bin
    zotero
    kdePackages.plasma-integration
  ];

  # Firefox PWA support
  programs.firefox.nativeMessagingHosts.packages = [pkgs.firefoxpwa];
}
