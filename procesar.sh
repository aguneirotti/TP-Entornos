#!/bin/bash

# First, navigate to the images folder
script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir/imagenes"

# Verify that images exist in the current folder
if [ ! -d "imagenes" ]; then
    echo "The folder does not exist or is empty"
    exit 1
fi

# Create a folder to store the new images
mkdir -p "imagenes_512x512"

# Resize the images to 512x512 using ImageMagick
echo "Resizing the images..."
sleep 1 # Just to make the execution more user-friendly
for image in imagenes/*.jpg; do
    filename=$(basename "$image")
    convert "$image" -resize 512x512^ -gravity center -extent 512x512 "imagenes_512x512/$filename"
done

echo "The image sizes have been successfully modified!"
