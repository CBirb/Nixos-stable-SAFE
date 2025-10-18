{ config, pkgs, lib, ... }:

{

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';

  # Musnix

  musnix.enable = true;

  musnix.alsaSeq.enable = true;

  musnix.rtcqs.enable = true;

  musnix.das_watchdog.enable = true;


  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
  #  kernel.sysctl = { "vm.swappiness" = 10; "fs.inotify.max_user_watches" = 524288; };
    kernelParams = [ "threadirq" ];
  # kernelPackages = let 
  #  rtKernel = pkgs.linuxPackagesFor (pkgs.linux.override {
  #    extraConfig = ''
  #      PREEMPT_RT_FULL? y
  #      PREEMPT y
  #      IOSCHED_DEADLINE y
  #      DEFAULT_DEADLINE y
  #      DEFAULT_IOSCHED "deadline"
  #      HPET_TIMER y
  #      CPU_FREQ n
  #      TREE_RCU_TRACE n
  #    '';
  #  }) pkgs.linuxPackages;
  # in rtKernel;

  postBootCommands = ''
    echo 2048 > /sys/class/rtc/rtc0/max_user_freq
    echo 2048 > /proc/sys/dev/hpet/max-user-freq
    setpci -v -d *:* latency_timer=b0
    setpci -v -s $00:1b.0 latency_timer=ff
  '';
  # The SOUND_CARD_PCI_ID can be obtained like so:
  # $ lspci ¦ grep -i audio
  };

  







}
