#Used AI for exercise 1 c) chatGPT
#!/bin/bash

# for loop to count to 5
for c in {1..5}; do
    echo "Count: $c"

    if [ "$c" -eq 3 ]; then
        echo "found the third item"
    fi
done

# Check that the user supplied a number
if [ -z "$1" ]; then
    echo "Please provide a number of processes."
    exit 1
fi

# Count the number of processes
ct=$(ps -ef | wc -l)

# Compare the process count with the number supplied
if [ "$ct" -gt "$1" ]; then
    echo "There are more than $1 processes running."
else
    echo "There are not more than $1 processes running."
fi

#Used AI for exercise 2 c) chatGPT
#promt Add a date/time stamp in the log file.
# Count the number of processes
ct=$(ps -ef | wc -l)

# Get the current date and time
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Check if the maximum number has been exceeded
if [ "$ct" -gt "$1" ]; then
    echo "$timestamp - Maximum number of processes exceeded" >> process.log
else
    echo "$timestamp - The maximum number of processes NOT exceeded" >> process.log
fi
 
#Used AI for exercise 3 b) chatGPT
#Modify the script so that the user can select which of the two behaviours s/he wants: That is, either writing to the screen (as implemented in Exercise 1) or writing to a file (as implemented in Exercise 2)
#!/bin/bash

# Ask the user where they want the output
echo "Select output method:"
echo "1. Write to screen"
echo "2. Write to file"
read -p "Enter your choice (1 or 2): " choice

# Count the number of processes
ct=$(ps -ef | wc -l)

if [ "$ct" -gt "$1" ]; then
    message="Maximum number of processes exceeded"
else
    message="The maximum number of processes NOT exceeded"
fi

# Output based on user's choice
if [ "$choice" -eq 1 ]; then
    echo "$message"
elif [ "$choice" -eq 2 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> process.log
else
    echo "Invalid choice"
fi
