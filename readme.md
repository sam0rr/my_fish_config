
# my_fish_config

Fish shell setup with a few helpers, aliases, and completions I use every day.

## Requirements
- Fish 3.x
- Arch-based package manager support is assumed for auto-installs (`pacman`, `paru`, or `yay`)
- Common tools: `git`, `zoxide`, `mise`, `eza`, `kitty`, `b3sum`, `gtrash`, `file`
- UI helpers (used by color picker and startup banner): `gum`, `yad`, `figlet`, `fastfetch`

## Install
Copy and paste in your terminal:

```bash
# Save old fish config
mv ~/.config/fish ~/.config/fish.bak.$(date +%Y%m%d%H%M%S) 2>/dev/null

# Clone fish config
git clone https://github.com/sam0rr/my_fish_config ~/.config/fish

# Reload fish config
source ~/.config/fish/config.fish
```

## What this config does
- `config.fish` runs `on_start` for interactive shells, initializes `zoxide` and `mise`, and auto-sets `FLUTTER_ROOT` based on the active `flutter` binary.
- `conf.d/` is empty so you can drop per-machine overrides there without touching the main config.
- Completions for `gtrash` are included under `completions/gtrash.fish`.

## Functions and aliases
- `on_start` – installs `figlet`/`fastfetch` if missing, prints a figlet banner of your username, and runs `fastfetch` on shell open.
- `ls` – alias to `eza -lah --icons --git` for an icon-filled directory view with Git info.
- `rm` – safety wrapper; shows a warning and exits. Use `command rm …` for actual deletion.
- `trash` – alias to `gtrash`, with completions bundled.
- `b3check [--print-hash] <ref_file> <file2> [file3 ...]` – hash the reference file with BLAKE3 and compare one or more targets, optionally showing the hash and transfer speed. Requires `b3sum`.
- `color_picker` – launches a YAD/Gum color picker, stores history in `~/.local/share/color_picker/`, rebuilds a palette, copies the hex code to the clipboard, and sends a desktop notification. Needs `gum`, `yad`, and optionally `notify-send`.
- `image-open <file>` – checks MIME type and previews supported images inline using `kitty +kitten icat`. Requires Kitty and the `file` command.
