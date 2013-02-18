#!/bin/sh

if [ -z $1 ]; then
	echo "You must specify the file to import."
	exit 1
fi

./script/rails runner lib/wine_score_parser.rb $1
