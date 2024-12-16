{lib, config, pkgs, ... }:

{
  users.users.akshat = {
    isNormalUser = true;
    description = "Akshat Adsule";
    extraGroups = [ "networkmanager" "wheel" ];
  }
}