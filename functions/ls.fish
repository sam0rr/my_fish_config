function ls --wraps='eza -lah --icons --git' --wraps='eza -lah --icons' --description 'alias ls=eza -lah --icons --git'
  eza -lah --icons --git $argv
        
end
