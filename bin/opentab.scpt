on run argv
  tell application "iTerm"
    activate
    tell current window
      set newWindow to (create tab with default profile)
      tell newWindow
        tell current session
          write text "" & item 1 of argv & ""
        end tell
      end tell
    end tell
  end tell
end run
