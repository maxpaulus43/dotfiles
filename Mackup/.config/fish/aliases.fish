# alias brca="brazil-recursive-cmd --matches '^(?!MShopAndroidPhoneApp).*$' -- 'brazil-build'"
alias bb="brazil-build"
alias bbx="brazil-build xcode-env"
alias brc="brazil-recursive-cmd --all"
alias brcp="BRAZIL_VERBOSE=true brazil-recursive-cmd-parallel --allPackages"
alias brcx="brazil-recursive-cmd -- 'brazil-build xcode-env'"
alias bu="bb -u"
alias bz="brazil"
alias ding="afplay /System/Library/Sounds/Glass.aiff"
alias gaa='git add --all'
alias gc='git commit -v'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'
alias glo="git log --pretty='format:%Cblue%h %Cgreen%<(15,trunc)%an %Cred%d %Creset %s'"
alias grhh='git reset HEAD --hard'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstp='git stash pop'
alias jtc='eval "$(pbpaste | jsonToCurl)" | jq | code -'
alias la='exa -1la'
alias ls='exa --icons'
alias nds="ninja-dev-sync"
alias studio="open -a ~/Applications/JetBrains\ Toolbox/Android\ Studio.app"
alias sz="source $__fish_config_dir/config.fish"
alias urldecode='node --eval "console.log(decodeURIComponent(process.argv[1]))"'
alias urlencode='node --eval "console.log(encodeURIComponent(process.argv[1]))"'
alias vd='nvim ~/c/dotfiles'
alias vim="nvim"
alias vn='nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
alias vz="nvim $__fish_config_dir/config.fish"

function lg
  set -gx LAZYGIT_NEW_DIR_FILE ~/.lazygit/newdir

  lazygit $argv

  if test -f $LAZYGIT_NEW_DIR_FILE 
    cd (cat $LAZYGIT_NEW_DIR_FILE)
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  end
end

