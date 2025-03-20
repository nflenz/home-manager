{ config, pkgs, ... }:

{

  imports = [
    ./bash.nix
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    # Add color to manpages
    MANPAGER = "sh -c 'sed -u -e \\\"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\\\" | bat -p -lman'";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nicholas";
  home.homeDirectory = "/home/nicholas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  services.flatpak.remotes = {
    "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  };

  services.flatpak.packages = [
    "flathub:app/com.discordapp.Discord"
  ];

  services.emacs = {
    package = pkgs.emacs-gtk;
    enable = true;
  };

  home.packages = with pkgs; [

    # Gaming
    sunshine
    ares

    # Comics
    yacreader
    
    # Editors
    emacs-gtk
    emacs-lsp-booster
    zile

    # Shells
    nodePackages.bash-language-server
    nushell
    powershell

    # VM/Cloud
    azure-cli azure-cli-extensions.containerapp azure-storage-azcopy
    terraform
    terraform-ls
    # gnome
    gnomeExtensions.caffeine
    dconf-editor
    gnome-tweaks
    gnomeExtensions.gsnap
    

    # Containers
    kubectl kind
    podman
    docker docker-compose dockerfile-language-server-nodejs

    # File systems
    sshfs
    ntfs3g
    encfs
    
    # Secrets
    keepassxc
    bitwarden
    age
    
    # Copying
    syncthing
    rsync

    # Searching
    ripgrep
    
    # Torrents
    # expressvpn
    qbittorrent

    # nix
    nixd
    niv
    nixos-generators
    vulnix

    # Ansible
    ansible
    ansible-language-server
    yaml-language-server
    # ansible-navigator
    ansible-lint

    # Markdown
    marksman

    # SQL
    postgresql
    sqls
    
    # Media
    spotify
    vlc
    mplayer mpv
    yt-dlp
    vdhcoapp

  ];

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

  programs.git = {
    enable = true;
    userName = "Nicholas Lenz";
    userEmail = "Nicholas Lenz";
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nicholas/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
