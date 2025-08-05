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
      homeConfig = homeFile: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matteo = homeFile;
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nix/thinkpad/configuration.nix
            home-manager.nixosModules.home-manager (homeConfig ./nix/thinkpad/home.nix)
          ];
        };
      };

      darwinConfigurations = {
        "MacBook-Pro-Matteo-De-JV2LG3X9JP" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/macbook/configuration.nix
            home-manager.darwinModules.home-manager (homeConfig ./nix/macbook/home.nix)
          ];
        };
      };
    };
}
