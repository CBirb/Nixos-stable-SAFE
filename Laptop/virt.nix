{ config, pkgs, ... }:


{
  # Libvirt
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  # };
  
  # Enable TPM emulation (optional)
  # virtualisation.libvirtd.qemu = {
  #   swtpm.enable = true;
  #   ovmf.packages = [ pkgs.OVMFFull.fd ];
  # };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = with pkgs; [ virtiofsd ];
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };



  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Virt-Manager
  programs.virt-manager.enable = true;

  # Waydroid
  virtualisation.waydroid.enable = true;
 
  # Flatpak
  services.flatpak.enable = true;


  # Container
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.  
  };

}
