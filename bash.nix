{ config, lib, pkgs, ... }:

{
  home.sessionPath = [
    "/usr/local/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    PAGER = "bat -n";
    MANPAGER = "sh -c 'sed -u -e \\\"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\\\" | bat -p -lman'";
    SYSTEMD_COLORS = "0";
    SYSTEMD_PAGER = "bat -l syslog";
    SYSTEMD_PAGERSECURE = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    BLOCK_SIZE = "human-readable";
  };

  programs.bash = {
    enable = true;
    sessionVariables = config.home.sessionVariables;

    shellAliases = {
      cd = "z";
      emacs = "emacsclient -c";
      cat = "bat -n";
      df = "grc df -x tmpfs -x devtmpfs -x efivarfs";
      pwsh = "pwsh -NoLogo";
      watch = "hwatch";
      nix-shell = "nix-shell --command zsh";
      dmesg = "sudo dmesg -T";
      hwatch = "hwatch -cp grc";
      magit = "emacsclient -t --eval '(magit)'";
      path = "echo $PATH | sed 's/:/\\n/g'";
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

      # Prevent C-s from freezing the terminal
      stty -ixon

      # colorize commands with grc
      GRC_ALIASES=true
      source ${pkgs.grc}/etc/profile.d/grc.sh
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    shellAliases = config.programs.bash.shellAliases;
    sessionVariables = config.home.sessionVariables;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autocd = true;

    initContent = ''
      # Configure keybindings to work like bash
      autoload -U select-word-style
      select-word-style bash
      bindkey '^T' transpose-chars

      # Bind other useful features
      bindkey '^[o' fzf-file-widget

      # cli completions with fzf
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zstyle ':fzf-tab:*' fzf-flags \
        '--bind=tab:accept' \
        '--bind=space:print-query' \
	'--bind=ctrl-space:put( )' \
        '--bind=bspace:backward-delete-char/eof'

      # # cache completions for azure
      # fpath=(~/.zsh/completions $fpath)
      # autoload -Uz compinit && compinit

      # pair symbols
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

      # add color to commands
      source ${pkgs.grc}/etc/grc.zsh

      # # Prevent C-s from freezing the terminal
      # if [[ -t 0 ]]; then
      #   stty -ixon
      # fi

      function cheat {
        env cheat $@ | bat -ppl bash
      }

      toggle_sudo() {
        if [[ $BUFFER == "" ]]; then
	        BUFFER="sudo $(fc -ln -1)"
	        zle end-of-line
        elif [[ $BUFFER =~ "sudo*" ]]; then
	        savcur=$CURSOR
	        BUFFER=$(echo $BUFFER | sed 's/^sudo //')
	        CURSOR=$(($savcur - 5))
        else
	        BUFFER="sudo $BUFFER"
	        CURSOR=$(($CURSOR + 5))
        fi
      }

      toggle_hwatch() {
        if [[ $BUFFER == "" ]]; then
	        BUFFER="hwatch $(fc -ln -1)"
	        zle end-of-line
        elif [[ $BUFFER =~ "hwatch*" ]]; then
	        savcur=$CURSOR
	        BUFFER=$(echo $BUFFER | sed 's/^hwatch //')
	        CURSOR=$(($savcur - 7))
        else
	        BUFFER="hwatch $BUFFER"
	        CURSOR=$(($CURSOR + 7))
        fi
      }

      toggle_pager() {
        if [[ $BUFFER == "" ]]; then
	        BUFFER="$(fc -ln -1) | \$PAGER"
	        zle end-of-line
        elif [[ $BUFFER =~ "PAGER" ]]; then
	        BUFFER=$(echo $BUFFER | sed 's/ *| \$PAGER//')
        else
	        BUFFER="$BUFFER | \$PAGER"
        fi
      }

      print_files() {
        savebuf=$BUFFER
        savecur=$CURSOR
        echo; ls; echo; echo
        zle reset-prompt
        BUFFER=$savebuf
        CURSOR=$savecur
      }

      git_status() {
        savebuf=$BUFFER
        savecur=$CURSOR
        echo; git status; echo; echo
        # echo; env ls -C --color=always; echo; echo
        zle reset-prompt
        BUFFER=$savebuf
        CURSOR=$savecur
      }

      autoload -Uz edit-command-line
      zle -N edit-command-line
      zle -N toggle_sudo
      zle -N toggle_hwatch
      zle -N toggle_pager
      zle -N print_files
      zle -N git_status
      bindkey '^[s' toggle_sudo
      bindkey '^[w' toggle_hwatch
      bindkey '^[p' toggle_pager
      bindkey '^[l' print_files
      bindkey '^[g' git_status
      bindkey '^[e' edit-command-line

      # # fzf-tab settings 
      # zstyle ':completion:*' fzf-search-display true
      # zstyle ':fzf-tab:complete:*' fzf-bindings 'space:toggle+down'
      # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      # zstyle ':fzf-tab:*' query-string prefix first

      # carapace settings
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

      # Fix grc's handling of ls
      unfunction ls
    '';    
  };

  programs.fish = {
    enable = true;
    shellAliases = config.programs.bash.shellAliases;

    # Disable the "welcome to fish" message
    shellInit = ''
      set -g fish_greeting ""

      # add color to commands
      source ${pkgs.grc}/etc/grc.fish
    '';

    plugins = [
      { name = "pisces"; src = pkgs.fishPlugins.pisces.src; }
    ];
  };

  programs.nushell = {
    enable = true;
    # Remove the aliases that replace nushell's builtin commands
    shellAliases = lib.attrsets.removeAttrs config.programs.bash.shellAliases [ "cd" "ls" "du" "ps" "watch" ];
    extraConfig = ''
      # disable the banner
      $env.config.show_banner = false

      # fix carapace completions
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
                               }
      $env.config.completions.external.completer = $carapace_completer
    '';
  };

  programs.atuin.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  # Configure starship
  programs.starship.enable = true;
  home.file = {
    ".config/starship.toml".source = dotfiles/starship.toml;
  };

  programs.carapace = {
    enable = true;
    # Seems to break completions for zsh
    # https://github.com/Aloxaf/fzf-tab/issues/503
    enableZshIntegration = false;
  };

  # Powershell ################################################################
  home.file.".config/powershell/profile.ps1".text = ''
      # enable starship
      Invoke-Expression (&starship init powershell)

      # enable carapace
      carapace _carapace powershell | Out-String | Invoke-Expression

      # enable atuin
      atuin init powershell | Out-String | Invoke-Expression
  '';

  # Xonsh #####################################################################
  home.file.".config/xonsh/rc.xsh".text = ''
    # enable starship
    execx($(starship init xonsh))

    # enable atuin
    execx($(atuin init xonsh))

    # enable carapace
    exec($(carapace _carapace xonsh))
  '';

  home.packages = with pkgs; [
    # Other shells
    powershell
    xonsh

    # Language servers
    fish-lsp
    bash-language-server
    powershell-editor-services

    # Dependencies for our shell configurations
    grc
    bat
    eza
    hwatch

    # Parsing text
    jq jqp
    yq

    # Modern spins on old commands
    fzf
    ripgrep

    # Easy learning
    cheat
    tldr

    # Record terminal
    asciinema

    # Networking
    iputils
    curl
    ipcalc
    wireshark
    mitmproxy
    mtr
    dog
    xh

    # systems performance
    bcc
    bpftrace
    strace
    strace-analyzer
    iperf
    sysstat

    # networking
    dig
    tcpdump
    nmap
    netcat

    # Copying
    rsync
    
  ];
}
