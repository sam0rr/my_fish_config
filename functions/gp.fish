function gp --wraps='gtrash put --rm-mode -r' --description 'alias gp=gtrash put --rm-mode -r'
    gtrash put --rm-mode -r $argv
end
