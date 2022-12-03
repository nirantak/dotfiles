#!/bin/bash
# Setup persistent apps in the macOS dock
set -eo pipefail

MODE=$1

__dock_item() {
  printf '%s%s%s%s%s' \
        '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
        '<key>_CFURLString</key><string>' \
        "$1" \
        '</string><key>_CFURLStringType</key><integer>0</integer>' \
        '</dict></dict></dict>'
}

echo "Setting up dock icons, mode: $MODE"

if [[ "$MODE" == "work" ]]; then
  defaults delete com.apple.dock persistent-apps
  defaults write com.apple.dock persistent-apps -array \
    "$(__dock_item /Applications/Google\ Chrome.app)" \
    "$(__dock_item /Applications/Microsoft\ Outlook.app)" \
    "$(__dock_item /Applications/Slack.app)" \
    "$(__dock_item /Applications/Microsoft\ Teams.app)" \
    "$(__dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(__dock_item /Applications/iTerm.app)" \
    "$(__dock_item /Applications/Spotify.app)" \
    "$(__dock_item /Applications/Notion.app)" \
    "$(__dock_item /System/Applications/Utilities/Activity\ Monitor.app)" \
    "$(__dock_item /System/Applications/System\ Preferences.app)"
elif [[ "$MODE" == "personal" ]]; then
  defaults delete com.apple.dock persistent-apps
  defaults write com.apple.dock persistent-apps -array \
    "$(__dock_item /Applications/Google\ Chrome.app)" \
    "$(__dock_item /Applications/Spotify.app)" \
    "$(__dock_item /Applications/Notion.app)" \
    "$(__dock_item /Applications/iTerm.app)" \
    "$(__dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(__dock_item /System/Applications/Utilities/Activity\ Monitor.app)" \
    "$(__dock_item /System/Applications/System\ Settings.app)"
elif [[ "$MODE" == "clear" ]]; then
  echo "Clearing recent apps list"
  defaults delete com.apple.dock recent-apps
else
  echo "Invalid mode provided!"
  exit 1
fi

killall Dock
