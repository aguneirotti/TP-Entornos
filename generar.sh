#!/bin/bash

# Primero vamos a adaptar el archivo csv crudo para que los nombres sean válidos

# Generamos un archivo csv sin los números
sed 's/,[0-9]*$//' nombres_crudo.csv > nombres_sin_numeros.csv
chmod 777 nombres_sin_numeros.csv

# Generamos un archivo csv con una palabra por línea
sed 's/ /\n/g' nombres_sin_numeros.csv > nombres.csv
chmod 777 nombres.csv

# Eliminamos el archivo csv auxiliar
rm nombres_sin_numeros.csv

NOMBRE_ALEATORIO=""
# Funcion para generar nombres al azar
function generar_nombres {
    nombres=($(cat nombres.csv))  # Lista de nombres de personas    
    indice_aleatorio=$(( RANDOM ))  # Generamos un indice aleatorio
    echo "${nombres[$indice_aleatorio]}"
    NOMBRE_ALEATORIO="${nombres[$indice_aleatorio]}"
    
}

#Le solicitamos al usuario que ingrese la cantidad de imagenes que desea generar
if [ $# -eq 0 ]; then
    echo "Ingresa la cantidad de imagenes que deseas generar: "
    read numero_imagenes
    if ! [[ "$numero_imagenes" =~ ^[1-9]+$ ]]; then
        echo "No ingresaste una opción válida."
        exit 1
    fi
else 
    echo "No ingresaste una opción válida."
    exit 1
fi

# Obtener el directorio del script
script_dir=$(dirname "$(readlink -f "$0")")

# Crear un directorio para almacenar las imágenes descargadas
mkdir -p "$script_dir/imagenes"
cd "$script_dir/imagenes" || exit 1

# Descargar imagenes de https://thispersondoesnotexist.com/
for ((i=1; i<=numero_imagenes; i++)); do
    generar_nombres
    archivo="$NOMBRE_ALEATORIO.jpg" # Generar nombre de archivo al azar
    wget -O "$archivo" "https://thispersondoesnotexist.com/"
    sleep 1  # Esperar 1 segundo antes de descargar la siguiente imagen  
done

# Volver al directorio del script
cd "$script_dir" || exit 1

# Comprimir las imágenes en un archivo zip
zip -r "imagenes.zip" "imagenes"/*.jpg

# Generar el archivo de suma de verificación (MD5)
md5sum "imagenes.zip" > "checksum.txt"

rm -r imagenes
echo "Proceso completo."
