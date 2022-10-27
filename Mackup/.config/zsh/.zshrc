HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000 # Maximum events for internal history
export SAVEHIST=50000 # Maximum events in history file

setopt appendhistory
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
zle_highlight=('paste:none')
HYPHEN_INSENSITIVE="true"

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
 
source "$ZDOTDIR/zsh-functions.zsh"
 
# Normal files to source
zsh_add_file "zsh-exports.zsh"
zsh_add_file "zsh-aliases.zsh"
zsh_add_file "zsh-vim-mode.zsh"
zsh_add_file "zsh-prompt.zsh"
zsh_add_file "colored-man-pages.zsh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

zsh_add_plugin "hlissner/zsh-autopair"

zsh_add_plugin "mafredri/zsh-async"
zsh_add_file "plugins/zsh-async/async.plugin.zsh" # have to do this because this plugin doesn't work with zsh_add_plugin function

 
# (NVM stuff)
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1
# End NVM stuff

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

