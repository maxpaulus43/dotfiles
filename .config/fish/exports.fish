set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden"
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --preview-window right:wrap --preview 'test -f {} && bat --style=numbers --color=always --line-range :500 {} || echo {}'"
set -gx GOPATH $HOME/go
set -gx JOURNAL_DIR $HOME/Google\ Drive/My\ Drive/notes/journals
set -gx LESS "-R -M --mouse --wheel-lines 3"
set -gx PAGER "less -R -M --mouse --wheel-lines 3"
set -gx MANPAGER 'nvim +Man!'
set -gx XDG_CONFIG_HOME $HOME/.config

# -p == "prepend"
fish_add_path -p $HOME/bin

# -a == "append"
fish_add_path -a $GOPATH/bin
