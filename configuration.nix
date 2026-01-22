{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
``
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
	i3blocks
     ];
    };
  };

  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
};
services.blueman.enable = true;
programs.zsh.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  users.users.tmonier = {
    isNormalUser = true;
    description = "tmonier";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };

 home-manager = {
	extraSpecialArgs = { inherit inputs; };
	users = {
		"tmonier" = import ./home.nix;
   };
 };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

 # Emacs
  services.emacs = {
  enable = true;
  defaultEditor = true;
  package = pkgs.emacs-pgtk;
 };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git 
    librewolf
    steam 
    nnn 
    gcc 
    neovim
    alacritty
    fd
    ripgrep
    fastfetch
    htop
    nerd-fonts.jetbrains-mono
    zsh
    curl
    spotify
    heroic
    networkmanagerapplet
    picom
    redshift
    xwallpaper
    pa_applet
    cbatticon
  ];


 programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
 };

  system.stateVersion = "25.11"; 
}
