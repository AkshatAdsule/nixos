{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    slack
    obsidian
  ];
}
