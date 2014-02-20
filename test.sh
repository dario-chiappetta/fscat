#!/bin/sh

if [ -z "$1" ]
then
	echo "No commit message defined. Aborting."
	exit 1
fi

echo "Success: $1"
