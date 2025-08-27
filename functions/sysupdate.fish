function sysupdate
    if command -q arch-update
        arch-update --noconfirm
    sudo sync
end
