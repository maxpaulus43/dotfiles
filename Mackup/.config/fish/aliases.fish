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
abbr v "nvim ."
abbr vd 'nvim ~/c/dotfiles'
abbr vim "nvim"
abbr vn 'nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
abbr vz "nvim $__fish_config_dir/config.fish"

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
