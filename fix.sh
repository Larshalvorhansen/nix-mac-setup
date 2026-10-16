set -e

# ---- 0. Backups ----
cd ~/nix-mac-setup
cp home/lhh.nix home/lhh.nix.bak.$(date +%s)
cp darwin/configuration.nix darwin/configuration.nix.bak.$(date +%s)
echo "✓ backups written next to originals (.bak.<timestamp>)"

# ---- 1. Strip the conflicting activationScripts block from darwin/configuration.nix ----
python3 - <<'PY'
import re, pathlib
p = pathlib.Path.home() / "nix-mac-setup/darwin/configuration.nix"
src = p.read_text()

# Remove the whole system.activationScripts.aerospaceConfig = { ... }; block
pattern = re.compile(
    r"\n\s*system\.activationScripts\.aerospaceConfig\s*=\s*\{.*?\n\s*\};",
    re.DOTALL,
)
new, n = pattern.subn("\n", src)
if n == 0:
    print("⚠ no activationScripts.aerospaceConfig block found — already clean?")
else:
    print(f"✓ removed {n} activationScripts.aerospaceConfig block(s)")

# Remove the stray chown line if it's still there
new2, n2 = re.subn(
    r"\n\s*chown -R lhh:staff /Users/lhh/\.config/aerospace\s*\n",
    "\n",
    new,
)
if n2:
    print(f"✓ removed {n2} chown line(s)")

p.write_text(new2)
PY

# ---- 2. Replace programs.aerospace block in home/lhh.nix ----
python3 - <<'PY'
import re, pathlib
p = pathlib.Path.home() / "nix-mac-setup/home/lhh.nix"
src = p.read_text()

new_block = r'''programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      config-version = 2;

      after-startup-command = [ "exec-and-forget sketchybar" ];
      exec-on-workspace-change = [
        "exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0"
      ];

      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      automatically-unhide-macos-hidden-apps = false;

      gaps = {
        inner.horizontal = 2;
        inner.vertical = 2;
        outer = {
          left = 2;
          right = 2;
          bottom = 2;
          top = 2;
        };
      };

      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";

        alt-tab = "workspace-back-and-forth";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";
        alt-f = "fullscreen";
        alt-shift-space = "flatten-workspace-tree";
      };
    };
  };'''

# Match from "programs.aerospace = {" up to its closing "};"
pattern = re.compile(
    r"programs\.aerospace\s*=\s*\{.*?\n\s*\};",
    re.DOTALL,
)
new, n = pattern.subn(new_block, src, count=1)
if n == 0:
    print("✗ could NOT find programs.aerospace block — aborting")
    raise SystemExit(1)
print(f"✓ rewrote programs.aerospace block ({n} match)")

p.write_text(new)
PY

# ---- 3. Remove stale duplicate config ----
rm -f ~/.config/aerospace/aerospace.toml
rmdir ~/.config/aerospace 2>/dev/null || true
echo "✓ removed stale ~/.config/aerospace/aerospace.toml (if it existed)"

# ---- 4. Rebuild ----
echo
echo "===== rebuilding (this may take a bit) ====="
darwin-rebuild switch --flake .#lhh

# ---- 5. Reload the running instance ----
echo
echo "===== reloading AeroSpace ====="
aerospace reload-config && echo "✓ reload-config clean"

echo
echo "===== workspaces visible to running instance ====="
aerospace list-workspaces --all

echo
echo "===== resulting ~/.aerospace.toml (first 40 lines) ====="
head -40 ~/.aerospace.toml

echo
echo "DONE."
