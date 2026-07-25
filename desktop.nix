{ config, pkgs, unstable, ... }:

{
  dconf.settings = {
    # Oh boy do I hate the system bell
    "org/gnome/Console" =  {
      audible-bell = false;
    };

    # Wallpaper settings
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/nicholas/Downloads/aishot-647.jpg";
      picture-uri-dark = "file:///home/nicholas/Downloads/aishot-647.jpg";
      primary-color = "#ff7800";
      secondary-color = "#000000";
      color-shading-type = "solid";
      picture-options = "zoom";
    };

    "org/gnome/desktop/media-handling" = {
      automount = true;
      automount-open = false;
    };
  };

  home.packages = with pkgs; [
    # Gaming
    sunshine
    ares
    mednafen

    # Books/Comics
    yacreader
    calibre

    # gnome
    gnomeExtensions.caffeine
    dconf-editor
    gnome-tweaks
    gnomeExtensions.gsnap

    # File systems
    sshfs
    ntfs3g
    encfs

    # Torrents
    expressvpn
    qbittorrent

    # Media
    vlc
    mplayer
    mpv
    yt-dlp
    plex-desktop

  ];
}

  
