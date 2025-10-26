{
  description = "NixOS configuration with Musnix and multiple nixpkgs channels";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-oldstable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-oldoldstable.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    musnix.url = "github:musnix/musnix";

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-oldstable, nixpkgs-oldoldstable, musnix, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        musnix.nixosModules.musnix

        ({
          nixpkgs.overlays = [
            (final: prev: {
              stable = import nixpkgs-stable {
                inherit system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [ 
                    "ventoy-qt5-1.1.05"
                    "qtwebengine-5.15.19"
                  ];
                };
              };

              oldstable = import nixpkgs-oldstable {
                inherit system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "ventoy-qt5-1.1.05"
                    "qtwebengine-5.15.19" 
                  ];
                };
              };

              oldoldstable = import nixpkgs-oldoldstable {
                inherit system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "ventoy-qt5-1.1.05"
                    "qtwebengine-5.15.19"
                  ];
                };
              };
            })
          ];
        })

        ./configuration.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.steve = ./home.nix; # replace <USERNAME> with your actual username
          }
      ];
    };
  };
}

