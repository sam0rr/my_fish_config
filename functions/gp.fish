function gp --wraps='gtrash put' --wraps='gtrash put --rm-mode' --description 'alias gp=gtrash put --rm-mode'
    gtrash put --rm-mode $argv
end
