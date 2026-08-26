function script --description 'Create a new executable bash script'
    if test (count $argv) -eq 0
        echo ""
        echo "Usage: script <name>"
        echo ""
        return 1
    end

    set -l filename "$argv[1].sh"

    if test -e $filename
        echo "Error: File '$filename' already exists."
        return 1
    end

    echo "#!/usr/bin/env bash" >$filename
    chmod +x $filename
    echo ""
    echo "Created executable script: $filename"
    echo ""
end
