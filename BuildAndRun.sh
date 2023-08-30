#!/bin/bash

# Parameters with default values
build="./builds"
source="./source"
name=$(basename "$(pwd)")
dontbuild=false

# Check if the first argument (build path) is provided
if [ -z "$1" ]; then
    echo "Error: Build path is required."
    exit 1
else
    build="$1"
fi

pdx="$build/$name.pdx"

# Create build folder if not present
if [ "$dontbuild" = false ]; then
    mkdir -p "$build"
fi

# Clean build folder
if [ "$dontbuild" = false ]; then
    rm -rf "$build/*"
fi

# Build
if [ "$dontbuild" = false ]; then
    pdc -sdkpath "$PLAYDATE_SDK_PATH" "$source" "$pdx"
fi

# Close Simulator
sim_pid=$(ps aux | grep PlaydateSimulator | grep -v grep | awk '{print $2}')
if [ ! -z "$sim_pid" ]; then
    kill -TERM "$sim_pid"
    count=0
    while kill -0 "$sim_pid" 2> /dev/null; do
        sleep 1
        count=$((count+1))
        if [ $count -ge 30 ]; then
            kill -KILL "$sim_pid"
        fi
    done
fi

# Run (Simulator)
open "$PLAYDATE_SDK_PATH/bin/Playdate Simulator.app" "$pdx"
