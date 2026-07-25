{ config, pkgs, unstable, ... }:

{
  home.packages = with pkgs; [
    # Gaming streaming
    sunshine

    # Launchers
    heroic
    lutris    

    # Emulators
    retroarch
    ares
    mednafen
    mednaffe
    dolphin-emu
    flycast

    # File systems
    sshfs
  ];

  # Define mount for console roms
  systemd.user = {
    mounts."home-nicholas-mnt-roms" = {
      Unit = {
	Description = "Mount ROMs from my NAS";
	After = [ "network-online.target" ];
	Wants = [ "network-online.target" ];
      };
      Mount = {
	What = "nas.nickiness.com:/Roms";
	Where = "/home/nicholas/mnt/roms";
	Type = "fuse.sshfs";
	Options = "ro";
      };
    };
    automounts."home-nicholas-mnt-roms" = {
      Unit = {
	Description = "Automount ROMs directory";
      };
      Automount = {
	Where = "/home/nicholas/mnt/roms";
	TimeoutIdleSec = "10min";
      };
      Install = {
	WantedBy = ["default.target"];
      };
    };
  };
}

  
