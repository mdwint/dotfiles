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

  outputs = { nixpkgs, home-manager, nix-darwin, ... }@args:
    {
      nixosConfigurations = {
        nixos = let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = args // { pkgs = pkgs; };
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.matteo = ./nixos/home.nix;
            }
          ];
        };
      };

      darwinConfigurations = {
        "MacBook-Pro-Matteo-De-JV2LG3X9JP" = let
          system = "aarch64-darwin";
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = args // { pkgs = pkgs; };
          modules = [
            ./nix-darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.matteo = ./nix-darwin/home.nix;
            }
          ];
        };
      };
    };
}
