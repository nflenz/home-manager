{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      "emacs" = "emacsclient -c";
      "cat" = "bat";
      "cheat" = "env cheat -c";
      "journalctl" = "SYSTEMD_PAGERSECURE=1 SYSTEMD_PAGER='bat -l syslog' env journalctl";
      "z" = "zoxide";
      "df" = "grc df";
    };

    bashrcExtra = ''
      source ~/.profile

      # Directory tracking in emacs with vterm
      source ${pkgs.bash-preexec}/share/bash/bash-preexec.sh
      
      vterm_printf() {
         printf "\e]%s\e\\" "$1"
      }

      precmd(){
         vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
      }

      # Better shell prompt
      source <(starship init bash --print-full-init)

      # Better history
      source <(atuin init bash)

      # Prevent C-s from freezing the terminal
      stty -ixon
    '';
  };

  programs.fish = {
    enable = true;
    shellAliases = config.programs.bash.shellAliases;

    shellInit = ''
      # Better history
      eval "$(atuin init fish)"

      # Better prompt
      eval "$(starship init fish --print-full-init)"
    '';
  };

  home.packages = with pkgs; [
    # Language servers
    fish-lsp
    bash-language-server
    powershell-editor-services

    # Dependencies for our bash configuration
    atuin
    starship
    bat
    grc

    # Parsing text
    jq jqp
    yq
    
    # Modern spins on old IsIcommands
    zoxide #-> cd
    eza #-> ls
    fzf #-> grep
    fd #-> find
    dust ncdu duf #-> du and df
    ripgrep #-> grep
    sd #-> sed

    glances
    grex

    # Easy learning
    cheat
    tldr
    
    # Makes it easier to implement vterm tracking in emacs
    bash-preexec

    # Record terminal
    asciinema

    # Networking
    iputils
    curl
    ipcalc
    wireshark
    mitmproxy
    mtr
    # dog
    xh
  ];
}
