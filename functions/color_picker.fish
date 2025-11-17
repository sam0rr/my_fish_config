# color_picker.fish
# Simple YAD-based color picker for Fish:
# - Stores selected hex colors in ~/.local/share/color_picker/history_colors
# - Rebuilds a YAD palette (~/.local/share/color_picker/palette.txt) from history
# - Shows colors in YAD with Name = "RGB: r,g,b"
# - Copies the picked hex color to the clipboard and sends a desktop notification

function _color_picker_ensure_deps
    if not type -q gum
        echo "gum is not installed. Installing with paru..."
        paru -S --needed gum
    end

    if not type -q yad
        gum style --foreground="#FF6B6B" "yad is not installed. Installing with paru..."
        paru -S --needed yad
    end
end

function _color_picker_get_default
    set -l history_file $argv[1]

    set -l default_color "#27A1B9"
    if test -f $history_file
        set -l first_line (head -n 1 $history_file)
        if test -n "$first_line"
            set default_color (string trim "$first_line")
        end
    end

    echo $default_color
end

function _color_picker_pick
    set -l default_color $argv[1]
    set -l palette_file $argv[2]

    set -l color (yad --color \
        --init-color="$default_color" \
        --gtk-palette \
        --palette="$palette_file" \
        --expand-palette \
        --mode=hex \
        --title="Color Picker" \
        --center \
        --on-top \
        --width=400 \
        --height=360 \
        --fixed)

    echo (string trim "$color")
end

function _color_picker_update_history
    set -l color $argv[1]
    set -l history_file $argv[2]

    set -l history_max 20
    set -l new_history $color

    if test -f $history_file
        for c in (cat $history_file)
            if test "$c" != "$color"
                set new_history $new_history $c
            end
        end
    end

    if test (count $new_history) -gt $history_max
        set new_history $new_history[1..$history_max]
    end

    printf "%s\n" $new_history > $history_file
end

function _color_picker_rebuild_palette
    set -l new_history_file $argv[1]
    set -l palette_file $argv[2]

    echo -n "" > $palette_file

    for hex in (cat $new_history_file)
        set -l raw (string replace -r '^#' '' "$hex")
        if test (string length -- "$raw") -lt 6
            continue
        end

        set -l r (printf '%d' 0x(string sub -s 1 -l 2 -- "$raw"))
        set -l g (printf '%d' 0x(string sub -s 3 -l 2 -- "$raw"))
        set -l b (printf '%d' 0x(string sub -s 5 -l 2 -- "$raw"))

        set -l name "RGB: $r,$g,$b"
        printf "%d %d %d %s\n" $r $g $b $name >> $palette_file
    end
end

function _color_picker_feedback
    set -l color $argv[1]

    if functions -q fish_clipboard_copy
        printf "%s" "$color" | fish_clipboard_copy
    end

    echo
    gum style --foreground="$color" --bold "Color copied: $color"
    echo

    if type -q notify-send
        notify-send "Color copied" "$color"
    end
end

function _internal_color_picker
    _color_picker_ensure_deps

    set -l state_dir ~/.local/share/color_picker
    set -l history_file $state_dir/history_colors
    set -l palette_file $state_dir/palette.txt
    mkdir -p $state_dir
    test -f $palette_file; or touch $palette_file

    set -l default_color (_color_picker_get_default $history_file)

    set -l color (_color_picker_pick $default_color $palette_file)

    set color (string trim "$color")
    if test -z "$color"
        gum style --foreground="#FF6B6B" "No color selected."
        return
    end

    set color (string sub -s 1 -l 7 -- "$color")

    _color_picker_update_history $color $history_file
    _color_picker_rebuild_palette $history_file $palette_file
    _color_picker_feedback $color
end

function color_picker
    _internal_color_picker
end
