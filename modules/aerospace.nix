{ config, lib, pkgs, ... }:

let
  gopath = "${pkgs.go}/share/go";

  aerospaceBin = pkgs.stdenv.mkDerivation {
    pname = "aerospace";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "nikitabobko";
      repo = "AeroSpace";
      rev = "1e19313b357647e15f4c59aa59a4c044aeb415f9";
      sha256 = "sha256-bU9PA26MFAO8BD2DGakTScLqtqz3LDiGTxlDpfFIjJ0=";
    };

    buildInputs = [ pkgs.go ];

    GOPATH = "$(mktemp -d)/gopath";

    buildPhase = ''
      mkdir -p "$GOPATH/src/github.com/nikitabobko"
      cp -r . "$GOPATH/src/github.com/nikitabobko/AeroSpace"
      cd "$GOPATH/src/github.com/nikitabobko/AeroSpace"
      export GOPATH="$GOPATH"
      export GOCACHE=$(mktemp -d)
      go build -o aerospace
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp aerospace $out/bin/
    '';
  };

  plistPath = "/Users/lhh/Library/LaunchAgents/dev.aerospace.plist";
  plistContents = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
     "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>dev.aerospace</string>
      <key>ProgramArguments</key>
      <array>
        <string>${aerospaceBin}/bin/aerospace</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>EnvironmentVariables</key>
      <dict>
        <key>PATH</key>
        <string>${pkgs.lib.makeBinPath [ pkgs.go pkgs.coreutils ]}</string>
      </dict>
    </dict>
    </plist>
  '';
in {
  environment.systemPackages = [ aerospaceBin ];

  system.activationScripts.aerospace = {
    text = ''
            echo "Installing AeroSpace LaunchAgent..."
            mkdir -p ~/Library/LaunchAgents
            cat > ${plistPath} <<EOF
      ${plistContents}
      EOF
            launchctl unload ${plistPath} || true
            launchctl load ${plistPath}
    '';
  };
}
