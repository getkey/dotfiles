{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> {};
in {
	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "getkey";
	home.homeDirectory = "/home/getkey";

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "21.11";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		# Editors
		unstable.neovim
		unstable.neovim-qt
		meld

		# Terminal emulators
		guake
		gnome.gnome-terminal

		# DevOps
		awscli2
		google-cloud-sdk
		kubectl
		kubectx
		heroku

		# Network
		whois
		dig

		# General dev CLI tools
		git
		ripgrep
		direnv
		fzf
		file

		# Dev
		nodejs
		yarn
		go
		rustc
		cargo
		rustfmt
		clippy
		gcc
		unstable.deno

		# Spell checking
		hunspell
		hunspellDicts.fr-reforme1990
		hunspellDicts.en-us-large

		# Messaging
		discord
		slack
		signal-desktop
		zoom-us
		thunderbird

		# File formats
		ffmpeg
		imagemagick
		optipng
		zip
		unzip
		gnome.file-roller
		lame
		flac

		# Recording
		obs-studio
		gnome.gnome-screenshot

		# Medias
		mpv
		gnome.eog
		quodlibet-full
		xmp
		pulseeffects-legacy
		milkytracker

		# Office
		evince
		libreoffice
		geogebra
		zettlr
		foliate

		# Image editing
		inkscape
		gimp

		# Browsers
		firefox
		chromium

		# System administration
		htop
		baobab
		gparted

		# Download
		transmission-gtk
		youtube-dl

		# 3D printing
		cura
		openscad

		# Games
		minecraft
		teeworlds
		steam

		# Misc
		keepassxc
		encfs
		libnotify
		wmctrl
		tree
		appimage-run
		xclip # needed for NeoVim to share the clipboard with the DE
	];

	home.sessionVariables = {
		RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
	};

	# Cloud
	services.syncthing.enable = true;
	services.nextcloud-client.enable = true;
	services.dropbox.enable = true;

	services.pulseeffects.enable = true;

	services.redshift = {
		enable = true;
		provider = "geoclue2";
		tray = true;
	};
}
