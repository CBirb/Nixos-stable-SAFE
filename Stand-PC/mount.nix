{ config, pkgs, lib, ... }:

{
  # Mounting Drives

  # Samsung
  fileSystems."/home/steve/Drives/Samsung" = {
    device = "/dev/disk/by-uuid/459daf8c-79ee-48ac-8c92-356c9bb02bf1";
    fsType = "btrfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
      "compress=zstd:15"
      "ssd"
    ];
   };
 
  # Micron
   fileSystems."/home/steve/Drives/Micron" = {
    device = "/dev/disk/by-uuid/bfb77242-0ed4-49cc-9b25-785b46df2598";
    fsType = "btrfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
      "compress=zstd:15"
      "ssd"
    ];
   };

  # Silver
  fileSystems."/home/steve/Drives/Silver" = {
    device = "/dev/disk/by-uuid/515cbbe8-9f41-4a8f-8967-37b6410f1a99";
    fsType = "btrfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
      "compress=zstd:15"
      "ssd"
    ];
   };

  # WD
  fileSystems."/home/steve/Drives/WD" = {
    device = "/dev/disk/by-uuid/8d61fc99-6382-4f72-ab72-25457efadc14";
    fsType = "ext4";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
    ];
   };

  # Seagate 
  # fileSystems."/home/steve/Drives/Seagate-Backup" = {
  #   device = "/dev/disk/by-uuid/f3e821ed-00b0-4f62-acd9-c6a3f10b39e7";
  #   fsType = "ext4";
  #   options = [ # If you don't have this options attribute, it'll default to "defaults" 
  #     # boot options for fstab. Search up fstab mount options you can use
  #     "users" # Allows any user to mount and unmount
  #     "nofail" # Prevent system from failing if this drive doesn't mount
  #     "exec" # Permit execution of binaries and other executable files
  #   ];
  #  };





}
