function sysupdate
    sudo apt update --fix-missing && \
    sudo apt full-upgrade -y --fix-missing && \
    sudo apt --fix-broken install -y && \
    sudo apt autoremove -y --purge && \
    sudo apt clean && \
    sudo sync
end

