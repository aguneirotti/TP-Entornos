#!/bin/bash

# First, adapt the raw CSV file

# Generate a CSV file without the numbers
sed 's/,[0-9]*$//' nombres_crudo.csv > nombres_sin_numeros.csv
chmod 777 nombres_sin_numeros.csv

# Generate a CSV file with one word per line
sed 's/ /\n/g' nombres_sin_numeros.csv > nombres.csv
chmod 777 nombres.csv

# Delete the auxiliary CSV file
rm nombres_sin_numeros.csv

# Ask the user to enter the number of images to generate
if [ $# -eq 0 ]; then
    echo "Enter the number of images you want to generate: "
    read numero_imagenes
    if ! [[ "$numero_imagenes" =~ ^[1-9]+$ ]]; then
        echo "You did not enter a valid option."
        exit 1
    fi
else 
    echo "You did not enter a valid option."
    exit 1
fi

NOMBRE_ALEATORIO=""  # Generate a global variable to use with the generate_names function

# Function to generate random names
function generar_nombres {
    nombres=($(cat nombres.csv))  # List of names    
    indice_aleatorio=$(( RANDOM ))  # Generate a random index
    echo "${nombres[$indice_aleatorio]}"
    NOMBRE_ALEATORIO="${nombres[$indice_aleatorio]}"  # Save the random name in the variable  
}

# Get the current directory of the script
script_dir=$(dirname "$(readlink -f "$0")")

# Create a directory to store the downloaded images
mkdir -p "$script_dir/imagenes"
# Copy the CSV file as an auxiliary to the folder where the images will be saved
cp "$script_dir/nombres.csv" "$script_dir/imagenes/"

# Navigate to the images folder to iterate
cd "$script_dir/imagenes" || exit 1

# Iterate calling the function and save in the images directory
for ((i=1; i<=numero_imagenes; i++)); do
    generar_nombres
    archivo="${NOMBRE_ALEATORIO}.jpg"  # Generate random file name
    curl -o "$archivo" "https://thispersondoesnotexist.com/"
    sleep 1  # Wait 1 second before downloading the next image
done

# Remove the auxiliary CSV file for neatness
rm nombres.csv

# Return to the script directory
cd "$script_dir"

# Compress the images into a zip file
zip -r imagenes.zip . -i imagenes/*.jpg

# Generate the checksum file
md5sum "imagenes.zip" > "checksum.txt"

# Move the .zip and .txt files to the images folder for neatness
mv imagenes.zip imagenes/
mv checksum.txt imagenes/

# Remove the generated images from the folder to present only the .zip and .txt files
rm -f imagenes/*.jpg

echo "The images have been successfully generated!"
