{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
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
    };
}
