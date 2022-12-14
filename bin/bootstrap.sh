#!/usr/bin/env bash

cd $HOME & mkdir c && cd c && git clone https://github.com/maxpaulus43/dotfiles.git && cd $HOME

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
  brew install bat # cat command with wings
  brew install btop # top on steroids
  brew install dust # du but better
  brew install exa # ls for the modern man
  brew install fd # find 
  brew install ffmpeg # image/video manipulations
  brew install fish # better shell
  brew install fzf # fuzzy finder
  brew install git
  brew install git-delta # better git diffs
  brew install lazygit # git UI
  brew install neovim # text editor
  brew install ripgrep # better grep
  brew install rlwrap # needed for ~/bin/cht
  brew install tealdeer # community driven man pages
  brew install tmux # terminal window manager
  brew install zoxide # cd but smarter

  if [[ $platform == 'macos' ]]; then
	  brew install --cask alacritty # terminal emulator
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
    brew install --cask raycast # better version of cmd+space
    brew install --cask shottr # cool screenshots
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
    echo '...You should run xcodes install --latest --select...'

    defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -int 0
    defaults write com.apple.dock showhidden -bool TRUE
    defaults write com.apple.screencapture showClicks -int 1
    defaults write com.apple.screencapture showsCursor -int 1
    defaults write com.apple.screencapture type jpg
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    killall Dock
  fi

  brew install mackup
  cp $HOME/c/dotfiles/Mackup/.mackup.cfg $HOME/.mackup.cfg
  mackup -v restore

  $(brew --prefix)/opt/fzf/install

  chmod +x $HOME/c/dotfiles/Mackup/bin/*

  fish_dir=$(which fish)
  echo "Adding '$fish_dir' to /etc/shells"
  sudo sh -c "echo $fish_dir >> /etc/shells"
  echo '...You should run chsh -s $(which fish)...'
fi





