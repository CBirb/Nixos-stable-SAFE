{ config, pkgs, lib, ... }:

{
  
  
  # Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  
   services.xserver.videoDrivers = [ "nvidia" ];
  

   hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    powerManagement.enable = true;

   
    powerManagement.finegrained = false;

    
    open = true;

    nvidiaSettings = true;

   
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };


  programs.obs-studio = {
    enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

   # Steam
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

  # Gamemode
  programs.gamemode.enable = true;


}
