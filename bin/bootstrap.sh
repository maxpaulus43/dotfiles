#!/usr/bin/env bash

cd "$HOME" && mkdir c && cd c && git clone https://github.com/maxpaulus43/dotfiles.git && cd "$HOME" || exit 1;

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
    # note I also needed to download 'g++' and 'make' from apt
  fi

  brew install asdf # version manager for node,ruby, etc...
  brew install bat # better cat
  brew install btop # better top
  brew install dust # better du
  brew install exa # better ls
  brew install fd # better find 
  brew install ffmpeg # image/video manipulations
  brew install fish # better shell
  brew install fzf # fuzzy finder
  brew install git
  brew install git-delta # better git diffs
  brew install lazygit # git UI
  brew install neovim # better vim
  brew install ripgrep # better grep
  brew install rlwrap # needed for ~/bin/cht
  # brew install tealdeer # community driven man pages
  brew install tmux # terminal window manager
  brew install zoxide # better cd
  brew install parallel # better xargs: build and execute shell command lines from standard input in parallel

  if [[ $platform == 'macos' ]]; then
    # brew install --cask alacritty # terminal emulator
    brew install --cask kitty # better terminal
    brew install --cask pixel-picker # color dropper tool
    brew install --cask spotify # music
    brew install --cask telegram # messages
    brew install --cask typora # markdown editor
    brew install --cask visual-studio-code # code
    brew install --cask android-studio # android studio
    brew install --cask audacity # audio recorder
    brew install --cask disk-inventory-x # windirstat for mac
    brew install --cask google-chrome # browser
    brew install --cask google-drive # cloud storage (keep notes here)
    # brew install --cask raycast # better version of cmd+space
    brew install --cask shottr # better screenshots
    brew install --cask slack # instant messenger
    brew install scrcpy # android screen stream program

    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font

    brew install mas # mac app store cli
    mas install 441258766 # magnet (window tile manager)
    mas install 668208984 # giphy capture
    mas install 897283731 # strongbox (password manager)
    mas install 1037126344 # Apple Configurator
    # mas install 497799835 # xcode (using xcodes cli instead)

    brew tap robotsandpencils/made
    brew install robotsandpencils/made/xcodes # xcode version picker
    # xcodes install --latest --select
    echo '...You should run "xcodes install --latest --select"...'

    defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # how fast keys repeat normal minimum is 2 (30 ms)
    defaults write com.apple.dock autohide-delay -float 0 # removes the animation of dock hide/show
    defaults write com.apple.dock autohide-time-modifier -int 0 # immediately hides/show dock with no delay
    defaults write com.apple.dock showhidden -bool TRUE # hides the dock
    defaults write com.apple.screencapture showClicks -int 1 # show screen capture clicks
    defaults write com.apple.screencapture showsCursor -int 1 # show cursor when capturing screen
    defaults write com.apple.screencapture type jpg # save screen caps as jpg (smaller file size)
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # allow press and hold keys in vscode
    killall Dock # restart dock to pick up new settings
  fi

  brew install mackup # tool for working with multiple dotfiles
  cp "$HOME"/c/dotfiles/Mackup/.mackup.cfg "$HOME"/.mackup.cfg
  mackup -v restore # symlink all dotfiles in this repo to my /~ folder

  "$(brew --prefix)"/opt/fzf/install # CTRL+r to enable fuzzy history search

  chmod +x "$HOME"/c/dotfiles/Mackup/bin/*

  bat ~/.tool-versions | \
    awk '{print $1}' | \
    parallel 'asdf plugin-add {}' # add plugins .tool-versions 

  asdf install # install tools from /~/.tool-versions file

  fish_dir="$(which fish)"
  echo "Adding '$fish_dir' to /etc/shells"
  sudo sh -c "echo $fish_dir >> /etc/shells"
  echo '...You should run chsh -s $(which fish)...'
fi





