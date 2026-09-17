function sysupdate
    echo ""
    arch-update

    echo ""
    mise up --yes --bump

    echo ""
    npx --yes t3@latest service install
    echo ""
    npx --yes t3@latest update --yes
    echo ""
    npx --yes t3@latest connect
    echo ""
    npx --yes t3@latest service status
    echo ""
    npx --yes t3@latest connect status

    echo ""
    echo "sysupdate done -> system is up to date"
    echo ""
end
