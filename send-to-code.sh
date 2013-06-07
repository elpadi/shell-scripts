#!/bin/bash

echo "Copying code to $CODE_DIR."

cd components

for r in harmony js-libs webcam; do
	echo "Copying repository $r."
	for f in `find "$r" -name '*.js'`; do
		if [ ! -f "$CODE_DIR/$f" ] || [ "$f" -nt "$CODE_DIR/$f" ]; then
			echo "$f"
			cp "$f" "$CODE_DIR/$f"
		fi
	done
done

cd ..
