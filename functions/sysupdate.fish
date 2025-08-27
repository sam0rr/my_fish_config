function sysupdate
    if command -q arch-update
        arch-update --noconfirm
    end
    sudo sync
end
