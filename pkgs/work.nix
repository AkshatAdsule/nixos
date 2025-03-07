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
    firefox-devedition-bin
    zotero
    kdePackages.plasma-integration
  ];
}
