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
    firefox-devedition
    zotero
    kdePackages.plasma-integration
  ];
}
