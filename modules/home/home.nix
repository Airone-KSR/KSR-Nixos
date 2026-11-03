{ config, pkgs, inputs, ... }:

{
  imports = [];

  home.username = "kaiserone";
  home.homeDirectory = "/home/kaiserone";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    TZ = "Africa/Kinshasa";
  };

  # On s'assure d'installer TOUTES les dépendances requises pour faire tourner HyDE sous Hyprland
  home.packages = [
    pkgs.google-chrome
    pkgs.mangohud
    pkgs.jetbrains-mono
    pkgs.acpi        
    pkgs.nautilus     
    pkgs.xarchiver        
    pkgs.unrar            
    pkgs.mpv              
    pkgs.libreoffice-fresh 
    pkgs.superfile        
    pkgs.aria2            
    
    # Outils indispensables pour le ricing de HyDE
    pkgs.rofi
    pkgs.waybar
    pkgs.swww
    pkgs.dunst
    pkgs.swappy
    pkgs.cliphist
    pkgs.brightnessctl
    pkgs.grim
    pkgs.slurp
    pkgs.faugus-launcher
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  xdg.desktopEntries.sklauncher = {
    name = "SKLauncher";
    exec = "java -jar /home/kaiserone/Applications/SKLauncher.jar";
    icon = "minecraft";
    comment = "Minecraft Launcher v4.0";
    categories = [ "Game" ];
    terminal = false;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrains Mono";
      font_size = "16.0";
      background_opacity = "1.0";
      confirm_os_window_close = "0";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rb = "nixos-rebuild switch";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kaiserone";
        email = "jjtchiteya07@gmail.com";
      };
    };
  };

  programs.home-manager.enable = true;
}

