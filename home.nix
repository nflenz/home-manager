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

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
      gh-eco
      gh-f
      gh-i
      gh-markdown-preview
      gh-s
    ];
  };

  home.packages = with pkgs; [

    # VC
    git
    gitleaks
    
    # Editors
    zile
    micro
    edwood

    # VM/Cloud
    (pkgs.azure-cli.withExtensions [
      azure-cli-extensions.ssh
      azure-cli-extensions.terraform
    ])
    cloudflared
    azure-storage-azcopy
    terraform
    pulumi-bin

    # kubernetes
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

    # Secrets
    keepassxc
    age
    
    # nix
    nixd
    niv
    nixos-generators
    vulnix
    comma
    nh
    nix-index

    # Ansible
    ansible
    ansible-navigator
    ansible-lint

    # Chef
    chef-cli

    # lua
    lua

    # C/C++
    gcc
    
    # java
    zulu

    # SQL
    postgresql
    
    # Security
    openssl
    sslscan

    # Networking
    wireshark

    # javascript
    nodejs

    clojure
    clojure-lsp
    babashka
  ];

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
