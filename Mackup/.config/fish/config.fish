if status is-interactive
  # Commands to run in interactive sessions can go here
  set fish_greeting

  if test (string match -ei 'Linux' (uname))
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  end

  if test (string match -ei 'Darwin' (uname))
    eval "$(/opt/homebrew/bin/brew shellenv)"
  end

  source "$__fish_config_dir/exports.fish"
  source "$__fish_config_dir/aliases.fish"
  source "$(brew --prefix)/opt/asdf/libexec/asdf.fish"

  fish_add_plugin "decors/fish-colored-man"
  fish_add_plugin "jorgebucaran/autopair.fish"
  # fish_add_plugin "2m/fish-history-merge"

  set -g man_blink -o red
  set -g man_bold -o green
  set -g man_standout -b b40bd6 white
  set -g man_underline -u 93a1a1
  set -g fish_pager_color_selected_background --background=533 
  set fish_color_selection white --bold --background=blue

  set fish_cursor_default block
  set fish_cursor_insert line blink
  set fish_cursor_replace_one underscore

  zoxide init fish | source

  if which tmux &> /dev/null \
    # && test ! -n "$visual_studio" \
    # && test ! (string match -eiq "screen" "$TERM") \
    # && test ! (string match -eiq "tmux" "$TERM") \
    && string match -eiq "alacritty" "$TERM"
    exec tmux new -AD -t main -s main
  else 
    alias tmain='tmux new -AD -t main -s main'
  end  

  function add_tea_environment --on-variable PWD; tea -Eds | source; end  #tea
end


