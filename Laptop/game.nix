{ config, pkgs, ... }:


{

  # as of 24.11
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
      driversi686Linux.amdvlk
    ];
  };


  ## Steam
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
  # hardware.xone.enable = true; # support for the xbox controller USB dongle
  services.getty.autologinUser = "steve";
  environment = {
    systemPackages = [ pkgs.mangohud ];
    loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
    '';
  };
  
  programs.gamemode.enable = true;



}
