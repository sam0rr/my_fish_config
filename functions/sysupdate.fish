function sysupdate
    echo ""
    arch-update

    echo ""
    mise up --yes --bump

    echo ""
    t3 service install
    echo ""
    t3 update --yes
    echo ""
    t3 connect
    echo ""
    t3 service status
    echo ""
    t3 connect status

    echo ""
    echo "sysupdate done -> system is up to date"
    echo ""
end
