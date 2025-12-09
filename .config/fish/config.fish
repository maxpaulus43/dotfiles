if status is-interactive
    set fish_greeting

    if test (string match -ei 'Linux' (uname))
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else if test (string match -ei 'Darwin' (uname))
        eval "$(/opt/homebrew/bin/brew shellenv)"
    end

    source "$__fish_config_dir/exports.fish"
    source "$__fish_config_dir/aliases.fish"

    fish_add_plugin "jorgebucaran/autopair.fish" # auto-close brackets/quotes

    set -g man_blink -o red
    set -g man_bold -o green
    set -g man_standout -b b40bd6 white
    set -g man_underline -u 93a1a1

    set -g fish_pager_color_selected_background --background=533
    set fish_color_selection white --bold --background=blue

    set fish_vi_force_cursor 1
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore

    if test "$TERM_PROGRAM" = vscode
        source (code --locate-shell-integration-path fish)
    end

    mise activate fish | source
    zoxide init fish | source
end
