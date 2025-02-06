#!/usr/bin/env sh
set -ex

osascript -e 'tell application "System Preferences" to quit'

# Keyboard
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false

# Menu bar
defaults write -g _HIHideMenuBar -bool true

# Dock
defaults write com.apple.dock orientation right
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-process-indicators -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect scale
defaults write com.apple.dock launchanim -bool false

# Finder
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true

killall Dock
killall Finder
