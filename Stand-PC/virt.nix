{ config, pkgs, lib, ... }:

{
  
   # Virt Manager
  virtualisation.libvirtd = {
    enable = true;
    # qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    qemu = {
      vhostUserPackages = with pkgs; [ virtiofsd ];
      swtpm.enable = true;
      # ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  programs.virt-manager.enable = true;



  # Waydroid
  virtualisation.waydroid.enable = true;

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Flathub
  services.flatpak.enable = true;

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };





}
