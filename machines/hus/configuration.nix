# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			/etc/nixos/hardware-configuration.nix
			<home-manager/nixos>
		];

	# stuff that the hardware scan missed
	boot.kernelModules = [ "amdgpu" ];
	hardware.enableAllFirmware = true;

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.supportedFilesystems = [ "ntfs" ];
	boot.tmp.cleanOnBoot = true;

	boot.kernelParams = [
		"processor.max_cstate=1" # Ryzen is known to be unstable on higher C-states, this should fix it
	];

	networking.hostName = "hus";
	networking.firewall.enable = false;

	# Set your time zone.
	time.timeZone = "Europe/Amsterdam";

	console = {
		 keyMap = "colemak";
	};

	services.xserver.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];
	services.xserver.desktopManager.cinnamon.enable = true;
	services.cinnamon.apps.enable = false;

	# The filesystem is encrypted with LUKS, so enable autoLogin
	services.xserver.displayManager.lightdm.enable = true;
	services.displayManager.autoLogin = {
		enable = true;
		user = "getkey";
	};

	# Configure keymap in X11
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.variant = "colemak";
	services.xserver.xkb.options = "caps:none";

	i18n.supportedLocales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

	nixpkgs.config.allowUnfree = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.getkey = {
		uid = 1000;
		isNormalUser = true;
		extraGroups = [
			"wheel"
			"networkmanager"
			"adbusers"
			"dialout" # access serial ports for Arduino
		];
		shell = pkgs.fish;
	};
	programs.fish.enable = true;
	home-manager.users.getkey = import /home/getkey/.config/nixpkgs/home.nix;

	programs.adb.enable = true;
	services.gvfs.enable = true;

	virtualisation.podman.enable = true;

	# used by redshift
	services.geoclue2.enable = true;
	location.provider = "geoclue2";

	# necessary for pulseeffects to work, see home-manager config
	programs.dconf.enable = true;

	services.postgresql.enable = true;
	services.postgresql.package = pkgs.postgresql_13;

	programs.steam.enable = true;

	nix.gc.automatic = true;
	nix.settings.auto-optimise-store = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?
}
