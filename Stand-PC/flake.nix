{
  description = "A very basic flake with Musnix support";

  inputs = {
    #   nixpkgs.url = "github:NixOS/nixpkgs/<branch name>";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05-small";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-oldstable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-oldoldstable.url = "github:NixOS/nixpkgs/nixos-24.05";
  
    musnix.url  = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-oldstable, nixpkgs-oldoldstable ,musnix, home-manager, ... } @ inputs: 
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
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };





}

