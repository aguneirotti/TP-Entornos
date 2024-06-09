#!/bin/bash
# First, navigate to the images folder
script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir/imagenes"

# Verify if there are indeed images in the folder
if [ ! -d "imagenes" ]; then
    echo "The images folder does not contain images or does not exist"
    exit 1
fi

# Create a file to save the list of image names
name_list="name_list.txt"

# Generate the list of image names
echo "Generating the list of image names..."
find . -name "*.jpg" -exec basename {} \; > "$name_list"
sleep 1
echo "The list of names has been successfully generated!"

# Create another file to save the list of valid names
valid_name_list="valid_name_list.txt"

# Generate the list of valid image names
echo "Generating the list of valid image names..."
find . -type f -name "*.jpg" -exec basename {} \; | grep "^[[:upper:]]" > "$valid_name_list"
sleep 2
echo "The list of valid names has been successfully generated!"

# Create a new file to save all names ending with the letter "a"
names_with_a_file="names_with_a.txt"

# Get the total number of names ending with "a"
echo "Calculating the total number of names ending with 'a'..."
find . -type f -name "*.jpg" -exec basename {} \; | grep "a.jpg" | wc -l > "$names_with_a_file"
sleep 2
echo "The new list has been successfully generated!"

# Compress everything generated into a single .zip file
cd $script_dir
#zip -r all.zip . -i imagenes/*
find imagenes -name "*.jpg" | zip -@ all.zip
chmod 777 all.zip
sleep 1
echo "Everything has been successfully compressed!"
