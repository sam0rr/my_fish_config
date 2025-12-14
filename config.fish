on_start

#Init Zoxide (cd)
zoxide init fish --cmd cd | source
mise activate fish | source

# Auto-set FLUTTER_ROOT based on whichever flutter is active
if type -q flutter
    set -gx FLUTTER_ROOT (dirname (dirname (realpath (command -s flutter))))
end
