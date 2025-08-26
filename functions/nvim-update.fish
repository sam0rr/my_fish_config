function nvim-update                                                                
    set -l nvim_path /usr/local/bin/nvim

    if not test -f $nvim_path
        echo "[ERROR] $nvim_path not found."
        return 1
    end
    
    echo ""
    echo "[INFO] Updating Neovim..."
    echo ""

    sudo appimageupdatetool $nvim_path
    if test $status -ne 0
        echo "[ERROR] Update failed."
        return 1
    end
    
    echo ""
    echo "[INFO] New Neovim version:"
    $nvim_path --version | head -n 2
    echo ""
end

