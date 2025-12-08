#!/usr/bin/env bash

platform='unknown'
unamestr=$(uname)

if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
fi

if [[ $platform == 'macos' || $platform == 'linux' ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $platform == 'linux' ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        sudo apt-get install g++ make
        # brew tap wez/wezterm-linuxbrew
        # brew install wezterm
    fi

    brew install coreutils
    brew install git
    brew install bat       # better cat
    brew install btop      # better top
    brew install eza       # better ls
    brew install fd        # better find
    brew install ffmpeg    # image/video manipulations
    brew install fish      # better shell
    brew install fzf       # fuzzy finder
    brew install git-delta # better git diffs
    brew install jq        # nice for working with json in the terminal
    brew install lazygit   # git UI
    brew install mise      # version manager for node, ruby, etc...
    brew install neovim    # better vim
    brew install parallel  # better xargs: build and execute shell command lines from standard input in parallel
    brew install ripgrep   # better grep
    brew install zoxide    # better cd
    brew install ollama    # running LLM's locally
    brew install stow      # symlink dotfiles folder to home folder
    brew instal gawk       # better awk
    brew install 7zip      # zip files

    if [[ $platform == 'macos' ]]; then
        brew tap homebrew/cask-fonts
        brew install --cask disk-inventory-x    # windirstat for mac
        brew install --cask docker              # virtual environments
        brew install --cask font-hack-nerd-font # better terminal font with symbols
        brew install --cask google-chrome       # browser
        brew install --cask google-drive        # cloud storage (keep notes here)
        brew install --cask intellij-idea       # good IDE
        brew install --cask mac-mouse-fix       # better mouse shortcuts
        brew install --cask obs                 # screen recorder
        brew install --cask slack               # instant messenger
        brew install --cask spotify             # music
        brew install --cask typora              # markdown editor
        brew install --cask visual-studio-code  # code
        brew install --cask wezterm             # terminal emulator that uses lua!
        brew install --cask raycast             # window/pasteboard/other manager

        brew install mas # mac app store cli
        # mas install 668208984  # giphy capture
        mas install 1481853033 # strongbox pro (password manager)

        defaults write -g InitialKeyRepeat -int 15                  # normal minimum is 15 (225 ms)
        defaults write -g KeyRepeat -int 1                          # how fast keys repeat normal minimum is 2 (30 ms)
        defaults write com.apple.dock autohide-delay -float 0       # removes the animation of dock hide/show
        defaults write com.apple.dock autohide-time-modifier -int 0 # immediately hides/show dock with no delay
        defaults write com.apple.dock showhidden -bool TRUE         # hides the dock
        defaults write com.apple.screencapture showClicks -int 1    # show screen capture clicks
        defaults write com.apple.screencapture showsCursor -int 1   # show cursor when capturing screen
        defaults write com.apple.screencapture type jpg             # save screen caps as jpg (smaller file size)
        defaults write -g ApplePressAndHoldEnabled -bool false      # allow press and hold keys to repeat
        killall Dock                                                # restart dock to pick up new settings
    fi

    "$(brew --prefix)"/opt/fzf/install # CTRL+r to enable fuzzy history search

    stow -d ~/c/dotfiles -t ~ .# symlink all my dotfiles to the ~ folder

    mise install # install tools from /~/.tool-versions file

    fish_dir="$(which fish)"
    echo "Adding '$fish_dir' to /etc/shells"
    sudo sh -c "echo $fish_dir >> /etc/shells"

    echo '...You should run chsh -s $(which fish)...'
fi
