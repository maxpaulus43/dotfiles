# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export DEFAULT_USER=maxpaulu
export PATH=$HOME/bin:$HOME/.toolbox/bin:$PATH
export PATH=/usr/local/opt/protobuf@3.1/bin:$PATH
export PATH=/Users/maxpaulu/Library/Python/3.7/bin:$PATH
export BRAZIL_BUILD_HOME=~/.toolbox
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk/
export ANDROID_HOME=$HOME/Library/Android/sdk
export LESS='-M --mouse --wheel-lines 3'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH=/Users/maxpaulu/.local/bin:$PATH
 
eval "$(zoxide init zsh)"

export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
