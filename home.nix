 { config, pkgs, unstable, ... }:

{
  imports = [
    ./bash.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
  };

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
    package = unstable.emacs31-nox;
    enable = true;
    startWithUserSession = true;
  };

  home.packages = with pkgs; [

    # Gaming[]
    sunshine
    ares

    # Books/Comics
    yacreader
    calibre

    # VC
    gitu
    gitleaks
    gh
    forgejo-cli
    jj
    
    # Editors
    unstable.emacs31-nox
    emacs-lsp-booster
    neovim-gtk
    vscode
    zile
    micro
    kakoune

    # VM/Cloud
    (pkgs.azure-cli.withExtensions [
      # azure-cli-extensions.interactive
      azure-cli-extensions.ssh
      azure-cli-extensions.terraform
      # azure-cli-extensions.alias
    ])
    cloudflared
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
    kubernetes-helm
    kustomize
    kubectl-images
    ktop
    krew
    kind
    k9s
    
    # Containers
    distrobox
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

    # Common LISP
    sbcl

    # java
    zulu
    jdt-language-server

    # ruby
    ruby
    solargraph

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
    plex-desktop

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

    # systems performance
    bcc
    bpftrace
    strace
    strace-analyzer
    iperf
    sysstat

    systemd-language-server
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
