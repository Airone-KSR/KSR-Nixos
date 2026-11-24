{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # 1. Pilotes Intel + décodage vidéo matériel (VA-API / QuickSync) + 32 bits
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # Pilote VA-API moderne pour Intel 10e gén (Comet Lake)
      intel-compute-runtime # Support OpenCL
      vpl-gpu-rt # Accélération vidéo Intel (OneVPL)
    ];
  };

  # Force l'utilisation du pilote moderne iHD pour l'accélération vidéo
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # 2. Steam + GE-Proton + GameMode (booste la fréquence CPU en jeu)
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  # 3. Vos outils et lanceurs
  environment.systemPackages = with pkgs; [
    mangohud
    faugus-launcher
    vulkan-tools
  ];
}
