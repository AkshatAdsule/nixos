{lib, config, pkgs, inputs, ... }:

{
  users.users.akshat = {
    isNormalUser = true;
    description = "Akshat Adsule";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    specialArgs = { inherit inputs; };
    users = {
      "akshat" = import ./home.nix;
    };
  };
}