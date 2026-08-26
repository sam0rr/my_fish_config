function rm --wraps rm --description 'Warn before destructive rm; use command rm for deletion'
    if count $argv >/dev/null
        if contains -- -h $argv; or contains -- --help $argv
            command rm $argv
            return $status
        end
    end

    printf '%s\n' 'rm is disabled to prevent accidents. Use "command rm" to delete.'
    return 1
end
