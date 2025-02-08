{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixpkgs.config.allowUnfree = true;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          modules = [ ./nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        matteo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./nixos/home.nix ];
        };
      };
    };
}
