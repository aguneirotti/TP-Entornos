#!/bin/bash

# Primero vamos a adaptar el archivo csv crudo 

# Generamos un archivo csv sin los números
sed 's/,[0-9]*$//' nombres_crudo.csv > nombres_sin_numeros.csv
chmod 777 nombres_sin_numeros.csv

# Generamos un archivo csv con una palabra por línea
sed 's/ /\n/g' nombres_sin_numeros.csv > nombres.csv
chmod 777 nombres.csv

# Eliminamos el archivo csv auxiliar
rm nombres_sin_numeros.csv


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

NOMBRE_ALEATORIO=""   #Generamos una variable global para usar con la funcion generar_nombres

# Funcion para generar nombres al azar

function generar_nombres {
    nombres=($(cat nombres.csv))  # Lista de nombres de personas    
    indice_aleatorio=$(( RANDOM ))  # Generamos un indice aleatorio
    echo "${nombres[$indice_aleatorio]}"
    NOMBRE_ALEATORIO="${nombres[$indice_aleatorio]}" #Guardamos el nombre aleatorio en la variable  
}


# Obtener el directorio actual del script
direccion_sript=$(dirname "$(readlink -f "$0")")

# Crear un directorio para almacenar las imágenes descargadas
mkdir -p "$direccion_sript/imagenes"
# Copiamos el archivo csv de forma auxiliar a la carpeta donde se guardaran las imagenes
cp "$direccion_sript/nombres.csv" "$direccion_sript/imagenes/"

# Nos movemos a la carpeta imagenes para luego iterar
cd "$direccion_sript/imagenes" || exit 1


# Iteramos llamando a la funcion y guardamos en el directorio imagenes
for ((i=1; i<=numero_imagenes; i++)); do
    generar_nombres
    archivo="${NOMBRE_ALEATORIO}.jpg" # Generar nombre de archivo al azar
    curl -o "$archivo" "https://thispersondoesnotexist.com/"
    sleep 1  # Esperar 1 segundo antes de descargar la siguiente imagen
done

#Removemos el csv auxiliar nombres por una cuestion de prolijidad
rm nombres.csv

# Volver al directorio del script
cd "$direccion_sript"

# Comprimir las imagenes en un archivo zip
zip -r imagenes.zip . -i imagenes/*.jpg

# Generar el archivo de suma de verificacion
md5sum "imagenes.zip" > "checksum.txt"

#Movemos los archivos .zip y .txt a la carpeta imagenes por una cuestion de prolijidad
mv imagenes.zip imagenes/
mv checksum.txt imagenes/

#Removemos las imagenes generadas de la carpeta con el obejtivo de presentar solamente los archivos .zip y .txt
rm -f imagenes/*.jpg

echo "Las imagenes se han generado exitosamente!"
