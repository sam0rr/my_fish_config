function gp --wraps gtrash --description 'Send files to trash via gtrash put'
    if not command -q gtrash
        printf '%s\n' 'gtrash is not available; install it or use "\rm" for permanent deletion.' >&2
        return 127
    end

    command gtrash put $argv
end
