#!/bin/bash
# vim: foldmethod=marker
sudo -v

# OSX ----------------------------------------------------- {{{
# Install available updates
sudo softwareupdate -iva
xcode-select --install
#}}}

# Homebrew ------------------------------------------------ {{{
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade --all
#}}}

# Developer Tools ----------------------------------------- {{{
# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

brew cask install java
brew install boot2docker
brew install docker
brew install fasd
brew install fzf
brew install htop
brew install hub
brew install jq
brew install nvim
brew install ranger
brew install reattach-to-user-namespace
brew install ripgrep
brew install tmux
brew install tree
brew install tty-clock
brew install weechat
brew install zsh-completions
#}}}

# Programming --------------------------------------------- {{{
brew install elixir
brew install lumo
brew install postgresql
brew install python3
brew install yarn
#}}}

# Applications -------------------------------------------- {{{
brew cask install google-chrome
brew cask install firefox
brew cask install slack
brew cask install flux
#}}}

# Fonts --------------------------------------------------- {{{
brew tap caskroom/fonts && brew cask install font-source-code-pro
#}}}

# Misc ------------------------------------------------ {{{
# Tmux Plugin Manager: use `prefix` + I to install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Intall custom terminfo that enables italics support
tic ./configs/xterm/xterm-256color-italic.terminfo
#}}}

# Dotfiles ------------------------------------------------ {{{
./bin/install-dotfiles.sh
#}}}
