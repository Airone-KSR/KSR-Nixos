# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix 
    ];
  boot = {
  # Active l'animation graphique (affiche le logo de ton PC + une roue de chargement par défaut)
  plymouth.enable = true;

  # Masque les lignes de texte du démarrage (Silent boot)
  consoleLogLevel = 3;
  kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
};
 boot.plymouth.theme = "solar";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
   # 2. Activer et configurer Limine
  boot.loader.limine = {
    enable = true;
    # Activez le support EFI si votre système utilise UEFI
    efiSupport = true; 
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = lib.mkForce inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Activation du support matériel Bluetooth et de son démon système (BlueZ)
  hardware.bluetooth = { 
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true; # Fournit un gestionnaire graphique si besoin
  # Set your time zone.
  time.timeZone = "Africa/Kinshasa";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ln_CD";
    LC_IDENTIFICATION = "ln_CD";
    LC_MEASUREMENT = "ln_CD";
    LC_MONETARY = "ln_CD";
    LC_NAME = "ln_CD";
    LC_NUMERIC = "ln_CD";
    LC_PAPER = "ln_CD";
    LC_TELEPHONE = "ln_CD";
    LC_TIME = "ln_CD";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."kaiserone" = {
    isNormalUser = true;
    description = "Kaiser";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    inputs.zen-browser.packages."${system}".default
    xdg-user-dirs  # <-- INDISPENSABLE pour que Serpantinum trouve le dossier PICTURES
    upower         # <-- INDISPENSABLE pour les modules de batterie du shell
  ];
 # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = lib.mkForce "26.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
   nix.settings = {
    substituters = [ 
      "https://cache.lantian.pub/lantian"
      "https://cache.xinux.uz" 
    ];
    trusted-public-keys = [ 
      "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
      "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    ];
  };
    # Activation du Nix Helper (nh)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos";
  };
  # 1. Optimisation des pilotes graphiques Intel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "modesetting" ];
  

  # 2. Activation de GameMode (optimisation CPU en jeu)
  programs.gamemode.enable = true;
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

  xdg.portal = { 
    enable = true;
    extraPortals = [ ];
    config.common.default = "*";
  };
  services.upower.enable = true; 
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  
  # 1. Automatisation du Nettoyage (Garbage Collector)
  nix.gc = {
    automatic = true;
    dates = "weekly";       # Le nettoyage se fera automatiquement toutes les semaines
    options = "--delete-older-than 12d"; # Supprime les fichiers vieux de plus de 7 jours
  };
  # 2. Optimisation automatique du stockage Nix
  nix.settings.auto-optimise-store = true; # Fusionne les fichiers identiques pour gagner de l'espace

  # 3. Automatisation des Mises à jour du système (Optionnel)
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";       # Cherche les mises à jour toutes les nuits à 4h du matin
    allowReboot = false;   # Ne redémarre pas le PC tout seul
  };
  programs.ryoku = {
            enable = true; 
 };
}
