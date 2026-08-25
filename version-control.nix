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
    gitleaks
    jujutsu

    # Git scripts
    (pkgs.writeShellScriptBin "better-branch.sh"
      (builtins.readFile ./scripts/better-branch.sh))
  ];

  programs.git = {
    enable = true;

    settings = {
      pull.rebase = true;
      rerere.enabled = true;
      push.autoSetupRemote = true;

      aliases = {
	amend = "commit --amend";
	bb = "!better-branch.sh";
	co = "checkout";
	lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
	nuke = "clean -fd";
	st = "status -sb";
	undo = "reset HEAD~1 --mixed";
      };

      user = {
	name = "Nicholas Lenz";
	email = "Nicholas Lenz";
      };
    };

    ignores = [
      "*~"
      "*.swp"
      ".env"
      ".direnv/"
      "result"
    ];

  };
}
