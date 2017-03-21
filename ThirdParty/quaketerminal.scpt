--checks System Events are ok

try
tell application "System Events" to tell process "Finder"
set frontmost to true

click menu item 3 of menu 1 of menu bar 1


end tell
on error

tell application "System Preferences"
launch
activate

reveal anchor "Privacy_Assistive" of pane id "com.apple.preference.security"

display alert "How to add QuakeTerminal to accessibilty" message "To add QuakeTerminal to the list of applications allowed" & return & return & "1) Click the lock icon at the bottom left of the System Prefences window, and enter your password" & return & return & "2) Click the accessibilty buttion on the left side of the System Preference window" & return & return & "3) Drag the icon of the QuakeTerminal into the list area displayed on the right side of the System Preference window. Or click the plus button to add"
end tell
quit
end try

-- Setting the unix path to app
set folpathme to path to me
set folpathmeunix to (POSIX path of folpathme)


-- this set the paths to unix paths
set fixedfullpath to folpathmeunix as string

set chars to every character of fixedfullpath

repeat with i from 2 to length of chars
if item i of chars as text is equal to "/" then
set item i of chars to "/"
else if item i of chars as text is equal to ":" then
set item i of chars to "/"
else if item i of chars as text is equal to "+" then
set item i of chars to " "
else if item i of chars as text is equal to "'" then
set item i of chars to "\\'"
else if item i of chars as text is equal to "\"" then
set item i of chars to "\\" & "\""
else if item i of chars as text is equal to "*" then
set item i of chars to "\\*"
else if item i of chars as text is equal to "?" then
set item i of chars to "\\?"
else if item i of chars as text is equal to " " then
set item i of chars to "\\ "
else if item i of chars as text is equal to "\\" then
set item i of chars to "\\\\"
end if
end repeat

set fixedfullpath to every item of chars as string

set fullpathicns to fixedfullpath & "contents/Resources/Quake_Terminal_Scripts/"

set mac_script_path to fullpathicns as string


--done setting paths


--Setup property's
property frist_run : false
property fin_quake_win : false
property size_quake_win : "300" as number
property mac_script_path : ""
property procesList : ""
property iterm_pidlist : ""








get_iterm_pid()

on get_iterm_pid()
tell application "System Events"
set {procesList, pidList} to the {name, unix id} of (every process whose name contains "Iterm2")
end tell

set iterm_pidlist to procesList as string
end get_iterm_pid


set no_assdev_script to true




app_startup()

on app_startup()
check_prefs()
read_prefs()
end app_startup


if procesList contains "iTerm2" then

kill_quake_win()

tell application iterm_pidlist
quit
end tell

end if

if frist_run is false then

if procesList does not contain "iTerm2" then

tell application "iTerm"
activate
end tell

get_iterm_pid()

make_quake_win()

end if
end if

if frist_run is true then
do shell script "sleep 5"

tell application iterm_pidlist
activate
end tell



make_quake_win()
end if


on make_quake_win()

tell application "System Events" to tell process iterm_pidlist
set frontmost to true
set win_resize to get size of window 1
set win_len to item 1 of win_resize
set win_hig to item 2 of win_resize
set is_resize_hig to false


repeat while is_resize_hig is false

if win_hig is less than size_quake_win then
set win_hig to win_hig + 1
set size of window 1 to {win_len, win_hig}

else
set is_resize_hig to true
end if


end repeat
end tell

set fin_quake_win to true

end make_quake_win

on kill_quake_win()

tell application "System Events" to tell process "iTerm2"
set frontmost to true

set win_resize to get size of window 1
set win_len to item 1 of win_resize
set win_hig to item 2 of win_resize
set is_resize_hig to false


repeat while is_resize_hig is false

if win_hig is greater than "1" then
set win_hig to win_hig - 1
set size of window 1 to {win_len, win_hig}

else
set is_resize_hig to true
end if


end repeat
end tell
end kill_quake_win

on check_prefs()

--checks the prefs file
try
do shell script "defaults read com.QuakeTerminal.plist PREF" as string
on error
do shell script "defaults write com.QuakeTerminal.plist PREF Yes"
end try

end check_prefs

on read_prefs()

try
do shell script "defaults read com.QuakeTerminal.plist is_welcome_installed " as string
on error
do shell script "mkdir -p /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "cat " & mac_script_path & "Welcome.sh > /usr/local/Quake_Terminal_Scripts/Welcome.sh" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/Welcome.sh" with administrator privileges
do shell script "chmod +x /usr/local/Quake_Terminal_Scripts/Welcome.sh" with administrator privileges

do shell script "defaults write com.QuakeTerminal.plist is_welcome_installed yes"
end try

try
do shell script "defaults read com.QuakeTerminal.plist is_display_installed " as string
on error
do shell script "mkdir -p /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "cat " & mac_script_path & "Displayinfo.sh > /usr/local/Quake_Terminal_Scripts/Displayinfo.sh" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/Displayinfo.sh" with administrator privileges
do shell script "chmod +x /usr/local/Quake_Terminal_Scripts/Displayinfo.sh" with administrator privileges

do shell script "defaults write com.QuakeTerminal.plist is_display_installed yes"
end try

try
do shell script "defaults read com.QuakeTerminal.plist is_cuspref_installed " as string
on error
do shell script "mkdir -p /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/" with administrator privileges
do shell script "cat " & mac_script_path & "com.googlecode.iterm2.plist > /usr/local/Quake_Terminal_Scripts/com.googlecode.iterm2.plist" with administrator privileges
do shell script "chmod 755 /usr/local/Quake_Terminal_Scripts/com.googlecode.iterm2.plist" with administrator privileges

do shell script "defaults write com.QuakeTerminal.plist is_cuspref_installed yes"

end try

try

do shell script "defaults read com.googlecode.iterm2.plist PrefsCustomFolder " as string
on error
do shell script "defaults write com.googlecode.iterm2.plist PromptOnQuit false"
do shell script "defaults write com.googlecode.iterm2.plist SUEnableAutomaticChecks false"

do shell script "defaults write com.googlecode.iterm2.plist PrefsCustomFolder /usr/local/Quake_Terminal_Scripts/"


tell application "iTerm"
activate
end tell

tell application "System Events" to tell process "iTerm2"
set frontmost to true
click menu item "Preferences..." of menu 2 of menu bar 1

--set winstuff to entire contents of front window
set theCheckbox to checkbox "Load preferences from a custom folder or URL:" of group 1 of window "Preferences" of application process "iTerm2" of application "System Events"
tell theCheckbox
if not (its value as boolean) then click theCheckbox

end tell
click menu item 22 of menu 2 of menu bar 1
end tell


set frist_run to true

end try

end read_prefs

