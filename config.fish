on_start

#Init Zoxide (cd)
zoxide init fish --cmd cd | source
mise activate fish | source

# Added by Antigravity CLI installer
set -gx PATH "/home/samor/.local/bin" $PATH
