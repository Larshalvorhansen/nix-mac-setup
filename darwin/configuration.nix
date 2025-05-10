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
	];

	services.nix-daemon.enable = true;
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
		"rectangle"
		"signal"
		"skim"
		"spotify"
		"vcv-rack"
		"balenaetcher"
	];

	system.defaults = {
		dock.autohide = true;
		dock.orientation = "left";
		dock.magnification = false;
		finder.AppleShowAllFiles = true;
		NSGlobalDomain.AppleKeyboardUIMode = 3;
		NSGlobalDomain."com.apple.keyboard.fnState" = true;

		# Remove this:
		# NSGlobalDomain."com.apple.controlcenter" = {
		#   "NSStatusItem Visible Brightness" = false;
		# };

		# notification."com.apple.ncprefs".doNotDisturb = true;
	};
}
