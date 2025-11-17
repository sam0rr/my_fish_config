function color_picker

    if not type -q gum
        echo "gum is not installed. Installing with paru..."
        paru -S --needed gum
    end
    
    if not type -q yad
        gum style --foreground="#FF6B6B" "yad is not installed. Installing with paru..."
        paru -S --needed yad
    end

    set default_color "#27A1B9"
    
    set color (yad --color \
        --init-color="$default_color" \
        --gtk-palette \
        --mode=hex \
        --center \
        --on-top \
        --width=400 \
        --height=300)
    
    if test $status -ne 0
        return
    end

    set color (string trim "$color")
    
    if test -z "$color"
        gum style --foreground="#FF6B6B" "No color selected."
        return
    end
    
    if functions -q fish_clipboard_copy
        printf "%s" "$color" | fish_clipboard_copy
    end

    echo ""
    gum style --foreground="$color" --bold "Color copied: $color"
    echo ""
    
    if type -q notify-send
        notify-send -u critical "Color copied" "$color"
    end
end
