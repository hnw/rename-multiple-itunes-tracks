on run
	tell application "iTunes"
		activate
		set selectedTracks to selection
		if selectedTracks is {} then
			activate
			beep 1
			display dialog "Select some tracks which you would like to rename before executing this script." with icon caution
		else
			-- create list of current song name
			set songNames to {}
			repeat with i in selectedTracks
				set songNames to songNames & {name of i}
			end repeat
			
			-- create multi-line text of current song name
			set saveDelimiter to AppleScript's text item delimiters
			set AppleScript's text item delimiters to return
			set songNameText to songNames as text
			set AppleScript's text item delimiters to saveDelimiter
			
			display dialog "Renaming " & (count songNames) & " tracks below." & return & "Input new track names." default answer songNameText buttons {"Cancel", "OK"} default button 2
			set {text returned:newSongNameText, button returned:clickedBtn} to result
			
			-- ignore last new line
			if newSongNameText is not "" then
				set n to length of newSongNameText
				if item n of newSongNameText is return then
					set newSongNameText to text 1 thru -2 of newSongNameText
				end if
			end if
			
			-- create list of new song name
			set saveDelimiter to AppleScript's text item delimiters
			set AppleScript's text item delimiters to return
			set newSongNames to every text item of newSongNameText
			set AppleScript's text item delimiters to saveDelimiter
			
			if (clickedBtn is "OK") then
				if (length of songNames is not equal to length of newSongNames) then
					activate
					beep 1
					display dialog "ERROR: The number of new track names are different from the number of target tracks." & return & "(" & (count songNames) & "tracks -> " & (count newSongNames) & "tracks)" buttons {"OK"} default button 1 with icon caution
				else
					repeat with n from 1 to count of selectedTracks
						set selectedTrack to item n of selectedTracks
						set oldName to name of selectedTrack
						set newName to item n of newSongNames
						if oldName is not newName and newName is not "" then
							set name of selectedTrack to newName as text
						end if
					end repeat
				end if
			end if
		end if
	end tell
end run
