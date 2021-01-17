#!/usr/bin/bash
# puts number of items in markdown todo list in polybar

TODO_FILE="${HOME}/lib/TODO.md"
newestMod="$( stat -c '%Y' "${TODO_FILE}" )"
lastMod="$( cat "${HOME}/lib/TODO.last" )"

updateModule() {
	echo "${newestMod}" > "${HOME}/lib/TODO.last"
	WORKING="$( grep -cs -- '<!--a-->$' "${TODO_FILE}" )"
	TODO="$( grep -cs -- '^- \[ \]' "${TODO_FILE}" )"
	DONE="$( grep -cs -- '^- \[X\]' "${TODO_FILE}" )"
	if (( WORKING != 0 )); then
		if (( TODO > 10 )); then
			echo "! ${WORKING}  * ${TODO}  X ${DONE} ~"
		else
			EXTRA="$( grep -cs '^/\|^~' "${TODO_FILE}" )"
			echo "! ${WORKING}  % ${EXTRA}  * ${TODO}  X ${DONE} ~"
		fi
	else
		if (( TODO > 10 )); then
			echo "* ${TODO}  X ${DONE} ~"
		else
			EXTRA="$( grep -cs '^/\|^~' "${TODO_FILE}" )"
			echo "% ${EXTRA}  * ${TODO}  X ${DONE} ~"
		fi
	fi
}

if (( newestMod > lastMod )); then
	updateModule
elif [[ ! "$TODO_STARTED" ]]; then
	export TODO_STARTED=1
	updateModule
else
	exit 0
fi
