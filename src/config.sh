#!/bin/bash

# initial injection rate
injection_rate=0.005

# for creating a folder to save the output files
output_folder="output_files"
mkdir -p "$output_folder"

while (( $(bc <<< "$injection_rate <= 0.005") ))
do
    # Create a unique output file name based on the injection rate
    output_file="${output_folder}/output_injection_rate_${injection_rate}.txt"
    
    # Replace the injection_rate in the config file
    sed -i "s/^injection_rate\s*=\s*$injection_rate/injection_rate = $(printf "%.3f" $injection_rate)/" /workspaces/booksim2/src/examples/mesh88_lat
    
    ./booksim ./examples/mesh88_lat > "$output_file"

    injection_rate=$(bc <<< "$injection_rate + 0.005")
done
