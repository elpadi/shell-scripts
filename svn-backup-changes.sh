#!/bin/bash
#######################################################
#  SVN Stash                                          #
#  Saves working changes.                             #
#  -------------------------------------------------  #
#                                                     #
#  Usage:                                             #
#     $ svn-stash [stash dir] [branch dir]            #
#                                                     #
#  Public Domain Software -- Free to Use as You Like  #
#######################################################

backup=$1
branch=$2

[ "$backup" == '' ] && backup="stash_`date +%s`"
[ "$branch" == '' ] && branch="trunk"

dir="${backup}__$branch"

echo "Verifying $dir"
if [ -a "$dir" -a ! -e "$dir" ];then
	echo "Error: $dir exists and is not a directory."
	exit 1
fi

if [ ! -e "$dir" ];then
	echo "Creating directory $dir."
	mkdir -p "$dir"
fi

echo "Looking for changes in $branch";
cd "$branch"
files=$(svn stat | grep '^\(M\|A\)' | awk '{ print $2; }')

if [ "$files" == '' ];then
	echo "Error: No changes found."
	exit 1
fi

echo "Changes to be stashed:"
for f in $files;do echo "$f";done

cpio -pd "../$dir" <<< "$files"
echo "All done. Changes stashed to $dir."
exit 0
