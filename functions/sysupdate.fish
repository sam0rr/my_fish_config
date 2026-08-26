function sysupdate
    echo ""
    arch-update

    echo ""
    mise up --yes --bump

    echo ""
    npx --yes t3@latest service update
    echo ""
    npx --yes t3@latest connect
    echo ""
    npx --yes t3@latest connect status

    echo ""
    echo "sysupdate done -> system is up to date"
    echo ""
end
