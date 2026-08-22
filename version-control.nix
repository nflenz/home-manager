{ config, pkgs, unstable, ... }:

{
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
    git
    gitleaks
    jujutsu

    # Git scripts
    (pkgs.writeShellScriptBin "better-branch.sh"
      (builtins.readFile ./scripts/better-branch.sh))
  ];

  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      amend = "commit --amend";
    };
    settings.user = {
      name = "Nicholas Lenz";
      email = "Nicholas Lenz";
    };
  };
}
