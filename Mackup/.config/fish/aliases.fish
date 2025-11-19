# alias brca="brazil-recursive-cmd --matches '^(?!MShopAndroidPhoneApp).*$' -- 'brazil-build'"

abbr "..." "cd ../.."
abbr "...." "cd ../../.."
abbr "....." "cd ../../../.."
abbr bb brazil-build
abbr brc "brazil-recursive-cmd --all"
abbr brcp "BRAZIL_VERBOSE=true brazil-recursive-cmd-parallel --allPackages"
abbr brx brazil-runtime-exec
abbr bz brazil
abbr cat bat
abbr ding "afplay /System/Library/Sounds/Glass.aiff"
abbr gaa 'git add --all'
abbr gc 'git commit -v'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr gdca 'git diff --cached'
abbr gds 'git diff --staged'
abbr gf 'git fetch'
abbr gfa 'git fetch --all --prune --jobs=10'
abbr gfo 'git fetch origin'
abbr glo "git log --pretty='format:%Cblue%h %Cgreen%<(15,trunc)%an %Cred%d %Creset %s'"
abbr grhh 'git reset HEAD --hard'
abbr gst 'git status'
abbr gsta 'git stash push'
abbr gstaa 'git stash apply'
abbr gstp 'git stash pop'
abbr icat "wezterm imgcat"
abbr keycode_menu 'adb shell input keyevent "KEYCODE_MENU"'
abbr la 'eza -1la'
abbr ls 'eza --icons'
abbr mcp-inspector "npx @modelcontextprotocol/inspector npm start"
abbr pbjq "pbpaste | jq"
abbr scr 'scrcpy 1>/dev/null & && disown $last_pid'
abbr studio "open -a ~/Applications/JetBrains\ Toolbox/Android\ Studio.app"
abbr sz "source $__fish_config_dir/config.fish"
abbr tree "eza -T"
abbr typora "open -a typora"
abbr v nvim
abbr vd 'nvim ~/c/dotfiles'
abbr vf "nvim (fzf)"
abbr vgf 'git diff --name-only HEAD | xargs nvim' # vim git files
abbr vn 'nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
abbr vv "nvim ."
abbr vz "nvim $__fish_config_dir/config.fish"
abbr watch-cwd 'fswatch -o . | xargs -n1 -I {} osascript -l JavaScript -e "Application(\"chrome\").windows[0].tabs.whose({url: {_contains: \'$(pwd)\'}})[0].reload()"'

function lg
    set -gx LAZYGIT_NEW_DIR_FILE ~/.lazygit/newdir

    lazygit $argv

    if test -f $LAZYGIT_NEW_DIR_FILE
        cd (cat $LAZYGIT_NEW_DIR_FILE)
        rm -f $LAZYGIT_NEW_DIR_FILE >/dev/null
    end
end

function mp4Desktop
    for i in ~/Desktop/*.{mov,MOV}
        mp4 $i && rm $i
    end
end
