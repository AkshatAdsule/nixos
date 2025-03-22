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
    kdePackages.plasma-integration
  ];
}
