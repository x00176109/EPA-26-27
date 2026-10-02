#!/bin/bash

# this is a comment
# Ask the user where they want the output
echo "Select output method:"
echo "1. Write to screen"
echo "2. Write to file"
read -p "Enter your choice (1 or 2): " choice

# for loop to count to 10
for c in {1..5}; do
	echo "Count: $c"

	# if does not use == it uses -eq
	# note the spaces around if [ ]
	if [ $c -eq 3 ]; then
		echo "found the third item"
	fi
done

# how do we pass parameters from the command line
# into this bash script. 
# we use the notation $1, $2 etc to represent
# the first, second etc parameter into this script
if [ -z $1 ]; then
	echo "You didn't pass any paraemters to $0"
else
	echo "You passed in $1 to $0"
fi

# heres a brand new command: 
# it calls ps -ef, then pipes it into word counter
# then stores the result in ct
ct=$(ps -ef | wc -l)

if [ "$ct" -gt "$1" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Maximum number of processes exceeded" >> process.log
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - The maximum number of processes NOT exceeded" >> process.log
fi

