#!/bin/bash
# Get the current directory of the script
script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir/imagenes"

# Check if the files exist
if [ ! -f "imagenes.zip" ]; then
    echo "The compressed images file (imagenes.zip) does not exist."
    exit 1
fi

if [ ! -f "checksum.txt" ]; then
    echo "The checksum file (checksum.txt) does not exist."
    exit 1
fi

# Unzip the images
echo "Unzipping the images..."
sleep 1
unzip "imagenes.zip"

if [ $? -ne 0 ]; then
    echo "An error occurred while unzipping the images."
    exit 1
fi

# Verify the checksum
echo "Verifying the checksum..."
md5sum -c "checksum.txt"

if [ $? -ne 0 ]; then
    echo "The checksum does not match. The files may be corrupted."
    exit 1
fi
sleep 1

echo "The images have been successfully unzipped!"
