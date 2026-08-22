{
  description = "Home Manager configuration of nicholas";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bios-saturn-usa = {
      url = "https://github.com/Abdess/retrobios/blob/main/bios/Sega/Saturn/mpr-17933.bin";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    unstable = import nixpkgs-unstable {
      inherit system;
        config.allowUnfree = true; 
      };
  in {

    homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = { inherit unstable; };

      modules = [
        ./home.nix
	./emacs.nix
	./version-control.nix
	./desktop.nix
	./gaming.nix
        ];
    };

    homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = { inherit unstable; };

      modules = [
        ./home.nix
	./version-control.nix
      ];
    };
  };
}
