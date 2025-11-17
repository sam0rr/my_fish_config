function copy
    set -l file $argv[1]
    if test -z "$file"
        echo "Usage: copy <file>"
        return 1
    end

    if not test -f $file
        echo "Error: '$file' not found or is not a regular file."
        return 1
    end

    if not type -q wl-copy
        echo "Error: wl-copy is not installed. Install wl-clipboard first."
        return 1
    end

    if not cat -- $file | wl-copy
        echo "Error: failed to copy '$file' to the clipboard."
        return 1
    end

    echo "Copied: $file"
end
