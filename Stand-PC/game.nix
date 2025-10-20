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

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module 
    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # OBS
  
  programs.obs-studio = {
    enable = true;

  # optional Nvidia hardware acceleration
   package = (
     pkgs.obs-studio.override {
       cudaSupport = true;
     }
   );

     plugins = with pkgs.obs-studio-plugins; [
       wlrobs
       obs-backgroundremoval
       obs-pipewire-audio-capture
       obs-vaapi #optional AMD hardware acceleration
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

  # Swappiness
  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 10;
  # };


}
