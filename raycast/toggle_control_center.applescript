#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Control Center
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Toggle Control Center
# @raycast.icon ⚙

# Documentation:
# @raycast.author Nirantak Raghav
# @raycast.authorURL https://nirantak.com
# @raycast.description Toggle Control Center on the macOS menu bar

tell application "System Events"
  tell process "Control Center"
    click menu bar item "control center" of menu bar 1
    log "Control Center Toggled"
  end tell
end tell
