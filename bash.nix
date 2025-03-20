{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      "emacs" = "emacsclient -c";
      "ls" = "eza";
      "cat" = "bat";
      "journalctl" = "SYSTEMD_PAGERSECURE=1 SYSTEMD_PAGER='bat -l syslog' ${pkgs.systemd}/bin/journalctl";
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
      source <(atuin init bash)'';
  };

  home.packages = with pkgs; [
    bash-language-server

    # Dependencies for our bash configuration
    bat tldr atuin eza starship
    
    # Makes it easier to implement vterm tracking in emacs
    bash-preexec
  ];
}
