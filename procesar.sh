#!/bin/bash

#Primeros nos movemos a la carpeta imagenes
direccion_sript=$(dirname "$(readlink -f "$0")")
cd "$direccion_sript/imagenes"

# Verificamos que existan las imagenes en la carpeta actual
if [ ! -d "imagenes" ]; then
    echo "La carpeta no existe o esta vacia"
    exit 1
fi

# Crear una carpeta para almacenar las nuevas imagenes

mkdir -p "imagenes_512x512"

# Recortamos las imagenes a 512x512 usando ImageMagick
echo "Modificando el tamaño de las imagenes..."
sleep 1 #Solo para hacer la ejecucion mas amigable
for imagen in imagenes/*.jpg; do
    nombre_archivo=$(basename "$imagen")
    convert "$imagen" -resize 512x512^ -gravity center -extent 512x512 "imagenes_512x512/$nombre_archivo"
done

echo "El tamaño de las imagenes a sido modificado exitosamente!"