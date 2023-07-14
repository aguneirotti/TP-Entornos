#!/bin/bash
# Obtener el directorio actual del script
direccion_sript=$(dirname "$(readlink -f "$0")")
cd "$direccion_sript/imagenes"

# Verificar si los archivos existen
if [ ! -f "imagenes.zip" ]; then
    echo "El archivo de imágenes comprimidas (imagenes.zip) no existe."
    exit 1
fi

if [ ! -f "checksum.txt" ]; then
    echo "El archivo de suma de verificación (checksum.txt) no existe."
    exit 1
fi

# Descomprimimos las imagenes
echo "Descomprimiendo las imagenes..."
sleep 1
unzip "imagenes.zip" 

if [ $? -ne 0 ]; then
    echo "Ocurrió un error al descomprimir las imagenes"
    exit 1
fi

# Verificamos la suma de verificacion
echo "Verificando la suma de verificacion..."
md5sum -c "checksum.txt"

if [ $? -ne 0 ]; then
    echo "La suma de verificación no coincide. Los archivos pueden estar corruptos."
    exit 1
fi
sleep 1

echo "Las imagenes han sido descomprimidas exitosamente!"

