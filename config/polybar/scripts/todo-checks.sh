#!/usr/bin/bash

newestMod=$( stat -c "%Y" ~/.TODO.txt )
lastEdit=$( cat ~/.TODO.last )

updateModule () {
	echo "$newestMod" > ~/.TODO.last
	WORKING=$( grep -cs '^!' "$HOME"/.TODO.txt )
	TODO=$( grep -cs '^*\|^!' "$HOME"/.TODO.txt )
	DONE=$( grep -cs '^X' "$HOME"/.TODO.txt )
	if (( WORKING != 0 )); then
		if (( TODO > 10 )); then
			echo "! $WORKING  * $TODO  X $DONE ~"
		else
			EXTRA=$( grep -cs '^/\|^~' "$HOME"/.TODO.txt )
			echo "! $WORKING  % $EXTRA  * $TODO  X $DONE ~"
		fi
	else
		if (( TODO > 10 )); then
			echo "* $TODO  X $DONE ~"
		else
			EXTRA=$( grep -cs '^/\|^~' "$HOME"/.TODO.txt )
			echo "% $EXTRA  * $TODO  X $DONE ~"
		fi
	fi
}

if [[ "$newestMod" -gt "$lastEdit" ]]; then
	updateModule
else
	exit 0
fi
