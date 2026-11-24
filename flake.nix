{
  description = "Configuration NixOS propre - kaiserone";

  inputs = {
    ryoku = {
      url = "github:Ryoku-dev/Ryoku-on-NixOS/main";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ski = {
      url = "github:ilyamiro/Ski";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ryoku, ski, self, nixpkgs, chaotic, zen-browser, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ryoku.nixosModules.default
          chaotic.nixosModules.default
          ./ryoku.nix
          ./hosts/nixos/hardware-configuration.nix
          ./hosts/nixos/configuration.nix
          "${ski}/nix/module.nix"
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kaiserone = import ./modules/home/home.nix;
          }
        ];
      };
    };
  };
}
