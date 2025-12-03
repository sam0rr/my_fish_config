# my_fish_config

### Copy and paste in your terminal emulator :

```bash
# Save old fish config
mv ~/.config/fish ~/.config/fish.bak.$(date +%Y%m%d%H%M%S) 2>/dev/null

# Clone fish config
git clone https://github.com/sam0rr/my_fish_config ~/.config/fish

# Reload fish config
source ~/.config/fish/config.fish
```

### Usage

- `b3check [--print-hash] <ref_file> <file2> [file3 ...]` – hash the reference file with BLAKE3 and compare
  one or more targets, optionally printing the matching hash and transfer speed.
- `color_picker` – launch the YAD / gum UI to pick a color, store it in the local palette/history, copy the
  hex code to the clipboard, and send a desktop notification.
- `image-open <file>` – check the MIME type and preview supported image files inline via `kitty +kitten icat`.
- `ls` – alias to `eza -lah --icons --git` so that every `ls` shows icons, Git status, and hidden files.
- `on_start` – helper that runs automatically in interactive shells to install prerequisites, render a figlet
  header with your username, and call `fastfetch`.
