{ config, pkgs, ... }:

{
  home.username = "tmonier";
  home.homeDirectory = "/home/tmonier";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
	pkgs.btop
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
