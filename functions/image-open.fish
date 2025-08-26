function image-open
    set file_path $argv[1]
    if test -z "$file_path"
        echo "Usage: image-open <file>"
        return 1
    end

    set mime_type (file --brief --mime-type "$file_path")

    if string match -q "image/*" "$mime_type"
        kitty +kitten icat "$file_path"
    else
        echo "Error: '$file_path' is not a valid image file."
        return 1
    end
end