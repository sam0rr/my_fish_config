function gr --wraps='gtrash restore-group' --wraps='gtrash rm' --wraps='gtrash prune' --description 'alias gr=gtrash prune'
    gtrash prune $argv
end
