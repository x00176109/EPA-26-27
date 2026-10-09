Q1 Claude 
used Claude to guide me through question

cores=$(grep -c "^processor" /proc/cpuinfo)   # count cores
if [ "$cores" -lt "$1" ]; then                # fewer than $1 cores?
    echo "Error: ..."; exit 1
fi

Q2 Claude 
num_cpu=$(grep "processor" /proc/cpuinfo | wc -l)   # steps 1–3
num_nproc=$(nproc)                                  # cgroup-aware count, for comparison

if [ "$num_cpu" -lt "$required" ]; then             # step 4
    echo "Error: ..."; exit 1
else
    echo "OK: ..."
fi


Q3 Claude 
to explain commands and show me how i could use in the script
