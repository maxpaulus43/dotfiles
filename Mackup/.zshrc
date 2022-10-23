# export ZDOTDIR=$HOME/.config/zsh

setopt AUTO_CD

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
 
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
 
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
 
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
 
# Plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions colored-man-pages)
 
source $ZSH/oh-my-zsh.sh
 
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
 
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'
 
# Max's custom options

export DEFAULT_USER=maxpaulu
export PATH=$HOME/bin:$HOME/.toolbox/bin:$PATH
export PATH=/usr/local/opt/protobuf@3.1/bin:$PATH
export PATH=/Users/maxpaulu/Library/Python/3.7/bin:$PATH
export BRAZIL_BUILD_HOME=~/.toolbox
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk/
export ANDROID_HOME=$HOME/Library/Android/sdk
export LESS='-M --mouse --wheel-lines 3'
 
alias vim="nvim"
alias bz="brazil"
alias bb="brazil-build"
alias brc="brazil-recursive-cmd --all"
alias brcp="BRAZIL_VERBOSE=true brazil-recursive-cmd-parallel --allPackages"
alias nds="ninja-dev-sync"
alias bu="bb -u"
alias brca="brazil-recursive-cmd --matches '^(?!MShopAndroidPhoneApp).*$' -- 'brazil-build'"
alias brcx="brazil-recursive-cmd -- 'brazil-build xcode-env'"
alias bbx="brazil-build xcode-env"
alias vz="nvim ~/.zshrc"
alias sz="source ~/.zshrc"
alias ding="afplay /System/Library/Sounds/Glass.aiff"
alias studio="open -a ~/Applications/JetBrains\ Toolbox/Android\ Studio.app"
alias glo="git log --pretty='format:%Cblue%h %Cgreen%<(15,trunc)%an %Cred%d %Creset %s'"
alias urlencode='node --eval "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node --eval "console.log(decodeURIComponent(process.argv[1]))"'
alias vn='nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
alias cl='clear'
alias c='cd ~/c'

function csb() {
  rm -rf ~/Library/Developer/Xcode/DerivedData && nvm use 12 && brc 'brazil-build prepare-beta' && cd ../IPhone && BRAZIL_WORKSPACE_PATH=$(pwd -P) open -a ~/Downloads/Xcode.app IPhone.xcworkspace && nvm use 14
} 

eval "$(zoxide init zsh)"

# (NVM stuff)
# Install zsh-async if it’s not present
if [[ ! -a $HOME/.zsh-async ]]; then
  git clone git@github.com:mafredri/zsh-async.git $HOME/.zsh-async
fi
source $HOME/.zsh-async/async.zsh

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    # [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
}

# Initialize worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1
# End NVM stuff


# RDE completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
# end RDE completion
 
#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
 
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH=/Users/maxpaulu/.local/bin:$PATH

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ ! -n "$visual_studio" ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [[ "$TERM" =~ alacritty ]] && [ -z "$TMUX" ]; then
  exec tmux new -AD -t main -s main
else 
  alias tmux='exec tmux new -AD -t main -s main'
fi

if [[ "$(uname)" == 'Linux' ]]; then
  # Set PATH, MANPATH, etc., for Homebrew.
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
