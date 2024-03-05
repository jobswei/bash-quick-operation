#!/bin/bash

# Check if enough arguments were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 SOURCE_DIRECTORY DESTINATION_DIRECTORY"
    exit 1
fi

# Read command line arguments
src_dir=$(realpath "$1")
dest_dir=$(realpath "$2")

# Check if source directory exists
if [ ! -d "$src_dir" ]; then
    echo "Source directory does not exist: $src_dir"
    exit 1
fi

# Check if destination directory exists, if not create it
if [ ! -d "$dest_dir" ]; then
    echo "Destination directory does not exist, creating it: $dest_dir"
    mkdir -p "$dest_dir"
fi

# Iterate over all files and directories in the source directory
# and create a symbolic link in the destination directory for them
link_files() {
    local src="$1"
    local dest="$2"
    for item in "$src"/*; do
        # Skip if the wildcard didn't match anything
        [ -e "$item" ] || continue
        local base=$(basename "$item")
        local link_dest="$dest/$base"
        if [ -d "$item" ]; then
            # Directory: create the destination directory and recursively link contents
            [ -d "$link_dest" ] || mkdir -p "$link_dest"
            link_files "$item" "$link_dest"
        else
            # File: create a symbolic link
            ln -s "$item" "$link_dest"
        fi
    done
}

# Start linking process
link_files "$src_dir" "$dest_dir"

echo "Linking complete."

