#!/bin/bash

#primero vamos a adaptar el archivo csv crudo para que los nombres sean validos

#generamos un archivo csv sin los numeros

sed 's/,[0-9]*$//' nombres_crudo.csv > nombres_sin_numeros.csv

chmod -x nombres_sin_numeros.csv

#generamos otro archivo csv que elimine los nombres que no tienen apellido.

grep -Ev '^[A-Za-z]+\s*$' nombres_sin_numeros.csv > nombres_apellidos.csv

chmod -x nombres_apellidos.csv

#generamos otro archivo csv que convierta la primer letra de los nombres y apellidos a mayusculas.

sed -E 's/(^|\s+)([a-z])/\1\u\2/g' nombres_apellidos.csv > nombres_apellidos_validos.csv

chmod -x nombres_apellidos_validos.csv


# Función para generar nombres de archivo al azar
function generar_nombres {
    source nombres_apellidos_validos.csv nombres_apellidos_validos
    nombres=($nombres_apellidos_validos)  # Lista de nombres de personas    
    indice_aleatorio=$(( RANDOM % ${#nombres[@]} ))  # Generamos un indice aleatorio
    echo "${nombres[$indice_aleatorio]}"
    
}

#Le solicitamos al usuario que ingrese la cantidad de imagenes a generar
if [ $# -eq 0 ]; then
    echo "Ingresa la cantidad de imágenes que deseas generar: "
    read numero_imagenes $1
    if ! [[ "$numero_imagenes" =~ ^[0-9]+$ ]]; then
        echo "No ingresaste una opción válida."
        exit 1
    fi
else 
    echo "No ingresaste una opción válida."
    exit 1
fi

#Verificar si el número de imágenes se proporciona como argumento o se ingresó por teclado
#if [ -z "$numero_imagenes" ] || ! [[ "$numero_imagenes" =~ ^[0-9]+$ ]]; then
#    echo "No ingresaste una opción válida."
#    exit 1
#fi



# Obtener la cantidad de imágenes a generar
numero_imagenes=$2

# Crear un directorio para almacenar las imagenes descargadas
mkdir -p imagen
cd imagen || exit 1

# Descargar imagenes de https://thispersondoesnotexist.com/
for ((i=1; i<=numero_imagenes; i++)); do
    filename="$(generar_nombres).jpg"  # Generar nombre de archivo al azar
    curl -o "$filename" "https://thispersondoesnotexist.com/"
    sleep 2  # Esperar 2 segundos antes de descargar la siguiente imagen

    
done

# Comprobar si se descargaron imágenes válidas
num_files=$(ls -1q | wc -l)
if [ "$num_files" -eq 0 ]; then
    echo "No se pudieron descargar imágenes válidas."
    exit 1
fi

# Comprimir las imágenes en un archivo zip
zip -r images.zip ./*.jpg

# Generar el archivo de suma de verificación (MD5)
md5sum images.zip > checksum.txt

#borramos el archivo csv sin numeros
#rm archivo_sin_numeros.csv
echo "Proceso completo."
