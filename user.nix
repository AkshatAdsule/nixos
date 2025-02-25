{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.akshat = {
    isNormalUser = true;
    description = "Akshat Adsule";
    extraGroups = ["networkmanager" "wheel" "kvm" "libvirtd" "docker"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "akshat" = import ./home.nix;
    };
  };
}
