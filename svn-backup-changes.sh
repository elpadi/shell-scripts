#!/bin/bash

branch="trunk"
backup="something"
dir="${backup}_$branch"

echo "Copying to $dir"
if [ -a "$dir" -a ! -e "$dir" ];then
	echo "Error: $dir exists and is not a directory."
	exit 1
fi

[ ! -e "$dir" ] && mkdir "$dir"

cd "$branch"
echo "Looking for changes in " "$branch";
files=$(svn stat | grep '^\(M\|A\)' | awk '{ print $2; }')

for f in $files;do
	echo "Found $f"
done

cpio -pd "../$dir" <<< "$files"
echo "Done."
cd ..
