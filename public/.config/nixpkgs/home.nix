{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
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
	home.stateVersion = "23.05";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		# Editors
		neovim
		neovim-qt
		nodePackages.typescript-language-server
		meld
		jetbrains.idea-community

		# Terminal emulators
		guake
		gnome-terminal

		# DevOps
		awscli2
		(google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [gke-gcloud-auth-plugin]))
		google-cloud-sql-proxy
		kubectl
		kubectx
		gh
		unstable.flyctl
		corepack

		# Network
		whois
		dig

		# General dev CLI tools
		git
		ripgrep
		fzf
		file
		dos2unix
		tree
		jq
		moreutils
		gnupg

		# Dev
		nodejs
		go
		gopls
		gotools
		rustup
		gcc
		jdk
		python3
		hugo
		nodePackages.typescript
		sops
		terraform
		vscode-langservers-extracted
		yaml-language-server

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
		nodePackages.svgo
		zip
		unzip
		file-roller
		lame
		flac
		losslesscut-bin
		opusTools

		# Recording
		obs-studio
		gnome-screenshot
		audacity

		# Medias
		mpv
		eog
		quodlibet-full
		xmp
		milkytracker
		spotify

		# Office
		hunspell
		evince
		libreoffice
		zettlr
		foliate
		dropbox
		transmission_4-gtk
		appimage-run

		# Image editing
		inkscape
		gimp

		# Browsers
		firefox
		chromium
		tor-browser

		# System administration
		htop
		baobab
		gparted
		man-pages-posix

		# Crypto
		keepassxc
		gocryptfs

		# Misc
		wmctrl
		xclip # needed for NeoVim to share the clipboard with the DE
		xsel
	];

	home.sessionVariables = {
		RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
		DICPATH = "${pkgs.hunspellDicts.en-us-large}/share/hunspell:${pkgs.hunspellDicts.fr-reforme1990}/share/hunspell";
	};

	# Cloud
	services.syncthing.enable = true;
	services.nextcloud-client = {
		enable = true;
		startInBackground = true;
	};
	# services.dropbox.enable = true; # doesn't work

	services.easyeffects.enable = true;

	services.redshift = {
		enable = true;
		provider = "geoclue2";
		tray = true;
	};

	programs.direnv = {
		enable = true;
		enableFishIntegration = true;
		nix-direnv.enable = true;
	};

	systemd.user.services = {
		go-to-bed-warning = {
			Unit = {
				Description = "Warns that the computer will shut down to force me to go to bed";
				Requires = "graphical-session.target";
			};
			Service = {
				ExecStart = "${pkgs.libnotify}/bin/notify-send -u critical -t 0 'You will be forced to go to bed in 10 minutes'";
			};
		};
		go-to-bed = {
			Unit = {
				Description = "Shuts the computer down to force me to go to bed";
				Requires = "default.target";
			};
			Service = {
				ExecStart = "${pkgs.systemd}/bin/shutdown";
			};
		};
	};

	systemd.user.timers = {
		go-to-bed-warning = {
			Unit = {
				Description = "Warns that the computer will shut down to force me to go to bed";
			};
			Timer = {
				OnCalendar = "*-*-* 22:50:00";
				Unit = "go-to-bed-warning.service";
			};
			Install = {
				WantedBy = ["timers.target"];
			};
		};
		go-to-bed = {
			Unit = {
				Description = "Shuts the computer down to force me to go to bed";
			};
			Timer = {
				OnCalendar = "*-*-* 23:00:00";
				Unit = "go-to-bed.service";
			};
			Install = {
				WantedBy = ["timers.target"];
			};
		};
	};
}
