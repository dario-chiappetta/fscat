#!/bin/sh

if [ -z "$1" ]
then
	echo "No commit message defined. Aborting."
	exit 1
fi

git add --all
git commit -m "$1"
git push -u origin master
