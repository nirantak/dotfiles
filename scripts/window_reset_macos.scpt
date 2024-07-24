#!/usr/bin/osascript
# Set a predifined windows configuration for multiple monitors
# system_profiler SPDisplaysDataType -detailLevel | grep "Resolution:" | awk -F"Resolution: " '{print $2}'

tell application "Rectangle" to launch

tell application "System Events"
  set Focus to name of the first process whose frontmost is true
  tell application process "Dock" to set {dockWidth, dockHeight} to the size of list 1
  set dockWidth to dockWidth + 6
  # log dockWidth
  get the size of scroll area 1 of application process "Finder"
  set Display to {width:item 1, height:item 2} of the result

  activate application "Google Chrome"
  delay 0.5
  set Chrome to the front window of application process "Google Chrome"
  set position of Chrome to [dockWidth, 0]
  set size of Chrome to [the Display's width, the Display's height]

  set [_w, _h] to the size of Chrome
  set [_x, _y] to the position of Chrome
  set the size of Chrome to [1900, _h]
  set position of Chrome to [(_w + dockWidth - 1900) / 2, _y]

  activate application "Visual Studio Code"
  delay 0.5
  set VScode to the front window of application process "Electron"
  set position of VScode to [_x + _w / 3, _y]
  set size of VScode to [_w * 2 / 3, _h]

  activate application "Microsoft Outlook"
  delay 0.5
  set Outlook to the front window of application process "Microsoft Outlook"
  tell application "System Events" to key code 36 using {control down, option down}

  activate application "Slack"
  delay 0.5
  set Slack to the front window of application process "Slack"
  tell application "System Events" to keystroke "e" using {control down, option down}

  activate application Focus
end tell
