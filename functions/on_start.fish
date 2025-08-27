function on_start
    if status is-interactive
        set color_art 5ad9e6

        if not command -q figlet
            echo "Figlet not found. Installing with pacman..."
            if command -q pacman
                sudo pacman -S --needed --noconfirm figlet
            else if command -q paru
                paru -S --needed --noconfirm figlet
            else if command -q yay
                yay -S --needed --noconfirm figlet
            else
                echo "No pacman/paru/yay found. Install figlet manually."
            end
        end

        if not command -q fastfetch
            echo "fastfetch not found. Installing with pacman..."
            if command -q pacman
                sudo pacman -S --needed --noconfirm fastfetch
            else if command -q paru
                paru -S --needed --noconfirm fastfetch
            else if command -q yay
                yay -S --needed --noconfirm fastfetch
            else
                echo "No pacman/paru/yay found. Install fastfetch manually."
            end
        end

        echo ""
        set_color $color_art
        if command -q figlet
            figlet (whoami)
        else
            echo (whoami)
        end
        set_color normal
        echo ""

        if command -q fastfetch
            fastfetch
        end
        echo ""
    end
end
