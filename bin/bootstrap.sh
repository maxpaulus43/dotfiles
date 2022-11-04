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
  fi

  brew install asdf # version manager for node,ruby, etc...
  brew install bat # cat command with wings
  brew install btop # top on steroids
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
  brew install tmux # terminal window manager
  brew install tree 
  brew install zoxide # cd but smarter

  if [[ $platform == 'macos' ]]; then
	  brew install --cask alacritty # terminal emulator
	  brew install --cask google-drive
	  brew install --cask pixel-picker
	  brew install --cask spotify
	  brew install --cask telegram
	  brew install --cask typora # markdown editor
	  brew install --cask visual-studio-code
    brew install --cask raycast # better version of cmd+space
    brew install --cask shottr # cool screenshots
    brew install scrcpy # android screen stream program

	  brew tap homebrew/cask-fonts 
	  brew install --cask font-hack-nerd-font
    
    defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -int 0
    defaults write com.apple.dock showhidden -bool TRUE
    defaults write com.apple.screencapture type jpg
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    killall Dock
  fi

  brew install mackup
  cp $HOME/c/dotfiles/Mackup/.mackup.cfg $HOME/.mackup.cfg
  mackup -v restore

  $(brew --prefix)/opt/fzf/install

  chmod +x $HOME/c/dotfiles/Mackup/bin/*

  echo "Changing default shell to fish:"
  fish_dir=$(which fish)
  sudo sh -c "echo $fish_dir >> /etc/shells"
  echo 'You should run chsh -s $(which fish)'

fi





