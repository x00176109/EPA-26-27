#!/bin/bash
# Checks that the VM has at least the number of CPU cores given by the user.

# New Bash builtin commands used in this version (from the GNU Bash manual):
#   1. read  - reads a line of input from the user into a variable
#   2. trap  - runs a command automatically when the script receives a signal or exits


# Function: explain the two new commands (called automatically at the end)

explain() {
    echo
    echo "------------------------------------------------------------------"
    echo "About this script (cpu_count3.sh)"
    echo "------------------------------------------------------------------"
    echo "1) read"
    echo "   'read' is a Bash builtin that reads a line of input into a variable."
    echo "   Options used: -p shows a prompt, -t 15 times out after 15 seconds,"
    echo "   and -r stops backslashes from being treated as escape characters."
    echo "   Improvement: in the previous version, forgetting \$1 just printed the"
    echo "   usage message and stopped. Now the script asks the user for the"
    echo "   minimum number of cores instead, and only shows the usage message"
    echo "   if nothing is typed (or the 15 seconds run out)."
    echo
    echo "2) trap"
    echo "   'trap' is a Bash builtin that runs a command when the script receives"
    echo "   a signal (e.g. INT, sent by Ctrl+C) or when it exits (EXIT)."
    echo "   Improvement: 'trap explain EXIT' guarantees this explanation is printed"
    echo "   at the end of the script whichever way it finishes (OK, error or usage),"
    echo "   without repeating the call before every 'exit'. 'trap ... INT' means"
    echo "   pressing Ctrl+C at the prompt prints a clear 'cancelled' message"
    echo "   and exits cleanly with code 130, instead of stopping silently."
    echo "------------------------------------------------------------------"
}

# Run 'explain' whenever the script exits, for any reason
trap explain EXIT

# If the user presses Ctrl+C, print a message and exit with the standard code 130
trap 'echo; echo "Cancelled by user (Ctrl+C)."; exit 130' INT

# ---------------------------------------------------------------------------
# Function: print a usage message and exit
# ---------------------------------------------------------------------------
usage() {
    echo "Usage: $(basename "$0") [MAX_NUM_CORES]"
    exit 1
}

# Too many arguments: show usage
if [ $# -gt 1 ]; then
    usage
fi

# No argument: ask the user for one with 'read' instead of giving up straight away
if [ $# -eq 0 ]; then
    echo "No minimum number of cores was supplied."
    if ! read -r -t 15 -p "Enter the minimum number of cores required: " required; then
        echo
        echo "No input received within 15 seconds."
        usage
    fi
    if [ -z "$required" ]; then
        usage
    fi
else
    required=$1
fi

# The value must be a positive whole number
if ! [[ "$required" =~ ^[0-9]+$ ]]; then
    echo "Error: '$required' is not a valid number of cores."
    usage
fi

# SEARCH cpuinfo for "processor", PIPE into a word count, STORE in num_cpu
num_cpu=$(grep "processor" /proc/cpuinfo | wc -l)

# For comparison: nproc is cgroup-aware
num_nproc=$(nproc)

echo "Cores reported by /proc/cpuinfo: $num_cpu"
echo "Cores reported by nproc:         $num_nproc"

if [ "$num_cpu" -ne "$num_nproc" ]; then
    echo "Note: the two counts differ (cgroup limits are probably in effect); nproc is the more reliable one."
fi

# PRINT an error if num_cpu is less than the required number, otherwise PRINT OK
if [ "$num_cpu" -lt "$required" ]; then
    echo "Error: this VM has only $num_cpu core(s), but at least $required are required."
    exit 1
else
    echo "OK: this VM has $num_cpu core(s), which meets the minimum of $required."
fi

exit 0
