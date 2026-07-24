{ config, pkgs, unstable, ... }:

{
  programs.emacs = {
    enable = true;
    package = unstable.emacs31-nox;    
    extraPackages = epkgs: with epkgs; [
      
      # Tree-sitter
      treesit-grammars.with-all-grammars

      # Editing
      beacon
      ctrlf
      expand-region
      kirigami
      multiple-cursors
      ryo-modal
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
      powershell
      rpm-spec-mode
      terraform-mode
      zig-ts-mode

      # Completion
      cape
      consult
      corfu
      embark
      orderless
      prescient
      vertico
      yasnippet-capf

      # Development
      aggressive-indent
      dape
      diff-hl
      direnv
      flycheck
      flycheck-eglot
      forge
      lsp-mode
      magit
      paredit
      projectile
      reformatter
      vc-jj
      yasnippet
      yasnippet-snippets

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
    bash-language-server
    dockerfile-language-server
    elixir-ls
    gopls
    jdt-language-server
    jinja-lsp
    just-lsp
    lua-language-server
    marksman
    nginx-language-server
    nixd
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
    zuban

    # Debuggers
    delve

  ];
}
