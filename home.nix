{ config, pkgs, unstable, ... }:

{
  imports = [
    ./bash.nix
  ];

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

  services.emacs = {
    package = pkgs.emacs-gtk;
    enable = true;
    startWithUserSession = true;
  };

  programs.neovim = {
    enable = true;
    # defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      neogit
    ];
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      redhat.vscode-yaml
      redhat.ansible
      hashicorp.terraform
      jnoortheen.nix-ide
      sumneko.lua
      tuttieee.emacs-mcx
    ];
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
    neovim-gtk
    vscode
    zile
    micro

    # VM/Cloud
    (pkgs.azure-cli.withExtensions [
      azure-cli-extensions.interactive
      azure-cli-extensions.ssh
      azure-cli-extensions.terraform
    ])
    azure-storage-azcopy
    terraform
    terraform-ls

    # gnome
    gnomeExtensions.caffeine
    dconf-editor
    gnome-tweaks
    gnomeExtensions.gsnap

    # kubernetes
    yaml-language-server
    kubectl
    kubectx
    # kubens
    kubernetes-helm
    kustomize
    kubectl-images
    ktop
    krew
    kind
    k9s
    
    # Containers
    podman
    buildah
    skopeo
    docker
    docker-compose
    dockerfile-language-server

    # File systems
    sshfs
    ntfs3g
    encfs
    
    # Secrets
    keepassxc
    bitwarden-desktop
    age
    
    # Copying
    syncthing
    rsync

    # Searching
    ripgrep
    
    # Torrents
    expressvpn
    qbittorrent

    # nix
    nixd
    niv
    nixos-generators
    vulnix
    comma

    # Ansible
    ansible
    unstable.ansible-language-server
    ansible-navigator
    ansible-lint

    # Chef
    chef-cli

    # python
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pip
      numpy
      pandas
      matplotlib
      django
      debugpy
    ]))
    # unstable.basedpyright
    unstable.zuban

    go
    delve

    # lua
    lua
    lua-language-server

    # C/C++
    gcc

    # java
    zulu
    jdt-language-server

    # javascript/typescript
    typescript-language-server
    vscode-js-debug

    # Markdown
    marksman

    # Jinja
    jinja-lsp

    # SQL
    postgresql
    sqls
    
    # Media
    vlc
    mplayer
    mpv
    yt-dlp
    vdhcoapp

    # Security
    openssl
    sslscan

    # Networking
    dig
    tcpdump
    nmap
    netcat
    wireshark

    # javascript
    nodejs
    node2nix

    # systems performance
    bcc
    bpftrace
    strace
    strace-analyzer
    iperf
    sysstat
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
    settings.user = {
      name = "Nicholas Lenz";
      email = "Nicholas Lenz";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
