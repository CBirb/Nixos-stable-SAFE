{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
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
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
   
  };
}

