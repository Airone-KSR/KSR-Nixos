{ config, pkgs, inputs, lib, ... }:

{
  hydenix = {
    enable = true;
    hostname = "nixos";
    timezone = "Africa/Kinshasa";
    locale = "fr_FR.UTF-8";
  };

  # Décommente la ligne ci-dessous uniquement si tu utilises GRUB ou Limine
   boot.loader.systemd-boot.enable = lib.mkForce false;
nixpkgs.overlays = lib.mkAfter [
    (final: prev: {
      gnomeExtensions = prev.gnomeExtensions // {
        window-gestures = prev.stdenv.mkDerivation {
          name = "window-gestures-dummy";
          dontUnpack = true;
          installPhase = "mkdir -p $out";
        };
      };
    })
  ];
}
