#!/bin/bash

python2_version=$(python2 --version 2>&1 | cut -f2 -d' ')
python3_version=$(python3 --version 2>/dev/null | cut -f2 -d' ')
echo $python2_version
echo $python3_version

if [ ! -z "$python2_version" ] || [ ! -z "$python3_version" ]
then
	if [ "$python3_version" \> "$python2_version" ]
	then
		echo "You better use python3"
	else
		echo "You better use python2"
	fi
else
	echo "You can't use python"
fi


