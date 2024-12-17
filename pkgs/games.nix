{
  config,
  pkgs,
  ...
}: {
  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Enable Lutris
  environment.systemPackages = [
    pkgs.lutris
  ];
  hardware.graphics.enable32Bit = true;
}
