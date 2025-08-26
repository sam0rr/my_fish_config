function on_start
    if status is-interactive
        set color_art 5AD9E6

        if not command -q figlet
            echo "Figlet is not installed. Attempting to install with apt..."
            sudo apt install -y figlet
        end

        echo ""
        set_color $color_art
        figlet (whoami)
	    set_color normal
        echo ""

        fastfetch
	echo ""
    end
end



