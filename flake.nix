{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
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

      darwinConfigurations = {
        "MacBook-Pro-Matteo-De-JV2LG3X9JP" = nix-darwin.lib.darwinSystem {
          modules = [ ./nix-darwin/configuration.nix ];
        };
      };
    };
}
