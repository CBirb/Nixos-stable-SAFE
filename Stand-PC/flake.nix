{
  description = "A very basic flake with Musnix support";

  inputs = {
    #   nixpkgs.url = "github:NixOS/nixpkgs/<branch name>";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05-small";

  
    # nix-snapd.url = "github:nix-community/nix-snapd";
    # nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    musnix.url  = "github:musnix/musnix";
    # home-manager = {
    #  url = "github:nix-community/home-manager/release-24.11";
    #  # url = "github:nix-community/home-manager/release-unstable";
    #  inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, musnix, home-manager, ... } @ inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ musnix.overlay ];
    };
  in
  rec {
    packages.${system} = {
      hello = pkgs.hello;
      default = pkgs.hello;
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          musnix.nixosModules.musnix
          ./configuration.nix
          # home-manager.nixosModules.home-manager
          # {
          #  home-manager.useGlobalPkgs = true;
          #  home-manager.useUserPackages = true;
          #  home-manager.users.steve = import ./home.nix;
          # }
          # nix-snapd.nixosModules.default
          # {
          #   services.snap.enable = true;
          # }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };





}

