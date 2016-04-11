#!/bin/bash

# Some truffle commands may require a special treatment
if [ $1 = "truffle" ]; then
	if [ $2 = "init" -o $2 = "compile" ]; then
		# Execute the command...
		$@
		# ... and, give ownership of the files in workspace
		# to whoever executed this one.
		# (Provided they gave us the right environment variables).
		if [ -n "$USER_ID" ] && [ -n "$GROUP_ID" ]; then
			chown -R $USER_ID:$GROUP_ID /workspace/.
		fi

		exit
	fi
fi

# Default case:
# Just run the given command
exec "$@"
