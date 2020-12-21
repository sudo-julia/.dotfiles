#!/usr/bin/bash
# puts number of items in markdown todo list in polybar

newestMod=$( stat -c "%Y" ~/.TODO.md )
lastMod=$( cat ~/.TODO.last )

updateModule () {
	echo "$newestMod" > ~/.TODO.last
	WORKING=$( grep -cs -- '<!--a-->$' "${HOME}"/.TODO.md )
	TODO=$( grep -cs -- '^- \[ \]' "${HOME}"/.TODO.md )
	DONE=$( grep -cs -- '^- \[X\]' "${HOME}"/.TODO.md )
	if (( WORKING != 0 )); then
		if (( TODO > 10 )); then
			echo "! $WORKING  * $TODO  X $DONE ~"
		else
			EXTRA=$( grep -cs '^/\|^~' "$HOME"/.TODO.md )
			echo "! $WORKING  % $EXTRA  * $TODO  X $DONE ~"
		fi
	else
		if (( TODO > 10 )); then
			echo "* $TODO  X $DONE ~"
		else
			EXTRA=$( grep -cs '^/\|^~' "$HOME"/.TODO.md )
			echo "% $EXTRA  * $TODO  X $DONE ~"
		fi
	fi
}

if [[ "$newestMod" -gt "$lastMod" ]]; then
	updateModule
else
	exit 0
fi
