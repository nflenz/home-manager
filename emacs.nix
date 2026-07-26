{ config, pkgs, unstable, ... }:

{
  programs.emacs = {
    enable = true;
    package = unstable.emacs31-nox;    
    extraPackages = epkgs: with epkgs; [
      
      # Tree-sitter
      treesit-grammars.with-all-grammars
      treesit-auto

      # Editing
      avy
      beacon
      ctrlf
      expand-region
      kirigami
      multiple-cursors
      ryo-modal
      surround
      visual-regexp
      vundo
      whitespace-cleanup-mode
      xah-fly-keys

      # Themes
      ef-themes

      # Language major modes
      ansible
      ansible-doc
      ansible-vault
      awk-ts-mode
      elixir-ts-mode
      haskell-ts-mode
      jinja2-mode
      jq-ts-mode
      just-ts-mode
      nginx-mode
      nix-ts-mode
      nushell-ts-mode
      perl-ts-mode
      powershell
      racket-mode
      rpm-spec-mode
      sly
      terraform-mode
      zig-ts-mode

      # Completion
      cape
      consult
      corfu
      corfu-prescient
      embark
      embark-consult
      marginalia
      orderless
      prescient
      vertico
      vertico-prescient
      yasnippet-capf

      # Development
      aggressive-indent
      consult-flycheck
      dape
      diff-hl
      direnv
      flycheck
      flycheck-eglot
      forge
      go-snippets
      lsp-mode
      magit
      paredit
      projectile
      reformatter
      sideline
      sideline-flycheck
      vc-jj
      yasnippet
      yasnippet-snippets

      # Documentation
      eldoc-box
      helpful
      terraform-doc

      # Terminal
      eat
      
      # AI
      gptel
    ];
  };

  services.emacs = {
    enable = true;
    startWithUserSession = true;
  };

  home.packages = with pkgs; [

    # For VC
    git
    jj
    
    # Improve lsp performance
    emacs-lsp-booster

    # LSP servers
    ansible-language-server
    awk-language-server
    basedpyright
    bash-language-server
    dockerfile-language-server
    elixir-ls
    gopls
    haskell-language-server
    jdt-language-server
    jinja-lsp
    jq-lsp
    just-lsp
    lua-language-server
    marksman
    nginx-language-server
    nixd
    perlnavigator
    powershell-editor-services
    rassumfrassum
    rust-analyzer
    solargraph
    sqls
    systemd-language-server
    terraform-ls
    typescript-language-server
    vscode-js-debug
    yaml-language-server
    zls
    zuban

    # Formatters
    jqfmt
    nixfmt
    terraform
    rubyfmt 
    rustfmt

    # Debuggers
    bashdb
    delve
    gdb

    # Compilers/Interpreters
    go
    lua
    racket
    rustc
    sbcl

    (python3.withPackages (python-pkgs: with python-pkgs; [
      debugpy
      django
      fabric
      kubernetes
      matplotlib
      numpy
      pandas
      paramiko
      pip
      psutil
      pytest
      python-hcl2
      requests
    ]))
    
    (perl.withPackages (p: with p; [
      PerlLanguageServer
    ]))

    (ruby.withPackages (p: with p; [
      thor
    ]))

    # Packaging
    fpm
    
  ];
}
