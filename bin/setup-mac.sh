#!/bin/bash
# vim: foldmethod=marker
sudo -v

# Settings ------------------------------------------------ {{{
# Disable smart quotes and dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Set the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist
#}}}

# Peripherals --------------------------------------------- {{{
# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable full keyboard access for all controls (i.e. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
#}}}

# Finder -------------------------------------------------- {{{
# Show hidden files by default
Defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
#}}}

# Dock ---------------------------------------------------- {{{
# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Change minimize/maximize window effect
# defaults write com.apple.dock mineffect -string "scale"

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
#}}}

# Time Machine -------------------------------------------- {{{
# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
#}}}

# Activity Monitor ---------------------------------------- {{{
# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
#}}}

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
brew upgrade
#}}}

# Developer Tools ----------------------------------------- {{{
# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

brew install hub
brew install git-extras
brew install zsh-completions
brew install nvim             # dark vim
brew install jq               # json explorer
brew install gron             # json flattener
brew install tree             # print nice file trees
brew install fasd             # easily jump to commonly-used directories
brew install fzf              # general purpose fuzzy-finder
$(brew --prefix)/opt/fzf/install
brew install htop             # better `top`
brew install tldr             # better `man`
brew install ripgrep          # better `grep`
brew install fd               # better `find`
brew install bat              # better `less` or `cat`
brew install tig              # better `git`
brew install diff-so-fancy    # better `git diff`
brew install pstree           # `ps` as a tree
brew install up               # write pipes with instant live preview
#}}}

# Applications -------------------------------------------- {{{
brew tap homebrew/cask-versions
brew install iterm2 --cask
brew install docker --cask
brew install slack --cask
brew install flux --cask
brew install gpg-suite --cask
#}}}

# Fonts --------------------------------------------------- {{{
brew tap caskroom/fonts
brew tap homebrew/cask-fonts
brew install font-source-code-pro --cask
brew install font-hack-nerd-font --cask
#}}}

# Dotfiles --------------------------------------------------- {{{
./setup-dotfiles.sh
#}}}
