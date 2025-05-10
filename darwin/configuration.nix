{ config, pkgs, ... }: {
# ... other nix-darwin system settings ...

# Define the user (lhh) and home for nix-darwin's sake:
	users.users.lhh = {
		home = "/Users/lhh";
		description = "Main user account";
# (You can include other user settings here if needed, 
#  but nix-darwin will not create this user; it assumes it exists.)
	};
	environment.systemPackages = with pkgs; [
		git
			tmux
			python3
			cmatrix
			typst
			eza
			neofetch
			ffmpeg
			glow
			neovim
	];
#	services.nix-daemon.enable = true;
	nix.package = pkgs.nix;

	programs.zsh.enable = true;

	homebrew.enable = true;
	homebrew.casks = [
		"ableton-live-standard"
			"aerospace"
			"alacritty"
			"bitwarden"
			"chatgpt"
			"element"
			"firefox"
			"google-chrome"
			"messenger"
			"minecraft"
			"pixelmator-pro"
			"raspberry-pi-imager"
			"signal"
			"skim"
			"spotify"
			"vcv-rack"
			"balenaetcher"
	];
	system.defaults = {
		dock = {
			autohide = true;
			orientation = "right";
			magnification = false;
			tilesize = 18;
			show-recents = false;
			autohide-delay = 0.0;
			autohide-time-modifier = 0.0;
			persistent-apps = [];
		};

		finder.AppleShowAllFiles = true;

		NSGlobalDomain = {
			AppleKeyboardUIMode = 3;
			"com.apple.keyboard.fnState" = true;
			_HIHideMenuBar = true;

# From screenshot:
			reduceMotion = true;
			increaseContrast = true;
# reduceTransparency = false; # default, so can be omitted
			autoPlayGIFs = true;
		};
	};

	system.stateVersion = 6;
		       }
