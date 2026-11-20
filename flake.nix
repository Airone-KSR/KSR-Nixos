{
  description = "Configuration NixOS propre - kaiserone";

  inputs = {
    ryoku = {
      url = "github:Ryoku-dev/Ryoku-on-NixOS/main";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ryoku, self, nixpkgs, nix-cachyos-kernel, zen-browser, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ryoku.nixosModules.default
          ./ryoku.nix
          ./hosts/nixos/hardware-configuration.nix
          ./hosts/nixos/configuration.nix
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
