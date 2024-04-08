# alias brca="brazil-recursive-cmd --matches '^(?!MShopAndroidPhoneApp).*$' -- 'brazil-build'"

abbr bb "brazil-build"
abbr bbx "brazil-build xcode-env"
abbr brc "brazil-recursive-cmd --all"
abbr brcp "BRAZIL_VERBOSE=true brazil-recursive-cmd-parallel --allPackages"
abbr brcx "brazil-recursive-cmd -- 'brazil-build xcode-env'"
abbr bu "bb -u"
abbr bz "brazil"
abbr cat "bat"
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
abbr icat "kitten icat"
abbr jtc 'eval "$(pbpaste | jsonToCurl)" | jq | code -'
abbr la 'exa -1la'
abbr ls 'exa --icons'
abbr nds "ninja-dev-sync"
abbr studio "open -a ~/Applications/JetBrains\ Toolbox/Android\ Studio.app"
abbr sz "source $__fish_config_dir/config.fish"
abbr tree "exa -T"
abbr typora "open -a typora"
abbr vv "nvim ."
abbr vd 'nvim ~/c/dotfiles'
abbr v "nvim"
abbr vf "nvim (fzf)"
abbr vn 'nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
abbr vz "nvim $__fish_config_dir/config.fish"
abbr cfg 'kitty +kitten config.py | less'
abbr watch-cwd 'fswatch -o . | xargs -n1 -I {} osascript -l JavaScript -e "Application(\"chrome\").windows[0].tabs.whose({url: {_contains: \'$(pwd)\'}})[0].reload()"'
abbr scr 'scrcpy 1>/dev/null & && disown $last_pid'
abbr dow 'date -j -f "%Y-%m-%d" +"%A"'

abbr keycode_menu 'adb shell input keyevent "KEYCODE_MENU"'
abbr home 'mshop-debug -i navigate "com.amazon.mobile.shopping://www.amazon.com"'
abbr live 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "2547231c-3c93-48cc-bec9-15e86c6fc062"}\' -s local -riL'
abbr inspire 'ssnap-launch -f immersivevisualexperience-nonmodal -l inspire_tab -p \'{"placementId": "inspire-feed"}\' -v non-modal -s local -riL'
# abbr vse 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "08841a86ef1b4acc8cfb6a3ef2e1e8c2", "source": "VSE"}\' -s local -riL'
abbr vse 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "0b24b6e6c5da452c821bcfbe3ac8c808", "source": "VSE"}\' -s local -riL'
abbr catamaran 'ssnap-launch -f amazon-live-catamaran -p \'{"placementId": "shopping-videos-home", "broadcastId": "ea65fbc8-5b39-43c2-a619-a4befb5249c9"}\' -s prod -riL'

function lg
  set -gx LAZYGIT_NEW_DIR_FILE ~/.lazygit/newdir

  lazygit $argv

  if test -f $LAZYGIT_NEW_DIR_FILE 
    cd (cat $LAZYGIT_NEW_DIR_FILE)
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  end
end

function mp4Desktop
  for i in ~/Desktop/*.{mov,MOV}
    mp4 $i && rm $i
  end
end
