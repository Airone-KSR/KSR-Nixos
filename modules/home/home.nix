{ config, pkgs, inputs, lib, ... }:

{
  imports = [ ];

  home.username = "kaiserone";
  home.homeDirectory = "/home/kaiserone";
  home.stateVersion = lib.mkForce "26.05";
  home.sessionVariables = {
    TZ = "Africa/Kinshasa";
  };

  # On s'assure d'installer TOUTES les dépendances requises pour faire tourner HyDE sous Hyprland
  home.packages = [
    pkgs.google-chrome
    pkgs.jetbrains-mono
    pkgs.acpi        
    pkgs.xarchiver        
    pkgs.unrar            
    pkgs.mpv              
    pkgs.libreoffice-qt 
    pkgs.superfile        
    pkgs.aria2                   
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "ski.desktop" ];
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

