if status is-interactive
  # Commands to run in interactive sessions can go here

  source "$__fish_config_dir/exports.fish"
  source "$__fish_config_dir/aliases.fish"

  fish_add_plugin "decors/fish-colored-man"
  fish_add_plugin "jorgebucaran/autopair.fish"

  if test (string match -ei 'Linux' $(uname))
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  end

  if which -s tmux \
    && test ! -n "$visual_studio" \
    && test ! (string match -eiq "screen" "$TERM") \
    && test ! (string match -eiq "tmux" "$TERM") \
    && test (string match -eiq "alacritty" "$TERM") \
    && test -z "$TMUX"
    exec tmux new -AD -t main -s main
  else 
    alias tmain='tmux new -AD -t main -s main'
  end  
   
end
