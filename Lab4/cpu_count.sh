#!/bin/bash


# Make sure the user passed exactly one argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <minimum_number_of_cores>"
    exit 1
fi

# Make sure the argument is a positive whole number
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: '$1' is not a valid number of cores."
    exit 1
fi

required=$1

# Steps 1-3: SEARCH cpuinfo for "processor", PIPE into a word count, STORE in num_cpu
num_cpu=$(grep "processor" /proc/cpuinfo | wc -l)

# For comparison: nproc is cgroup-aware, so it shows the cores this process may actually use
num_nproc=$(nproc)

if [ "$num_cpu" -ne "$num_nproc" ]; then
    echo "Note: the two counts differ (cgroup limits are probably in effect); nproc is the more reliable one."
fi

# Step 4: PRINT an error if num_cpu is less than the required number, otherwise PRINT OK
if [ "$num_cpu" -lt "$required" ]; then
    echo "Error: this VM has only $num_cpu core(s), but at least $required are required."
    exit 1
else
    echo "OK: this VM has $num_cpu core(s), which meets the minimum of $required."
fi

exit 0
