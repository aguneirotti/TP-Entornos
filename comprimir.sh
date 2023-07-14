#!/bin/bash
#Primero nos movemos a la carpeta imagenes
direccion_script=$(dirname "$(readlink -f "$0")")
cd "$direccion_script/imagenes"

# Verificamos si efectivamente hay imagenes en la carpeta
if [ ! -d "imagenes" ]; then
    echo "La carpeta imagenes no contiene imagenes o no existe"
    exit 1
fi

# Creamos un archivo para guardar la lista de nombres
lista_nombres="lista_nombres.txt"

# Generamos la lista de nombres de las imagenes
echo "Generando la lista de nombres..."
find . -name "*.jpg" -exec basename {} \; > "$lista_nombres"
sleep 1
echo "La lista de nombres a sido generada exitosamente!"


# Creamos otro archivo para guardar la lista de nombres validos
lista_nombres_validos="lista_nombres_validos.txt"

# Generamos la lista de nombres de imagenes validas
echo "Generando la lista de nombres de imagenes validas..."
find . -type f -name "*.jpg" -exec basename {} \; | grep "^[[:upper:]]" > "$lista_nombres_validos"
sleep 2
echo "La lista de nombres validos a sido generada exitosamente!"

# Creamos un nuevo archivo para guardar todas las personas cuyo nombre finaliza con la letra "a"
archivo_nuevo="nombres_con_a.txt"

# Obtener el total de personas cuyo nombre finaliza con "a"
echo "Calculando el total de personas cuyo nombre finaliza con 'a'..."
find . -type f -name "*.jpg" -exec basename {} \; | grep "a.jpg" | wc -l > "$archivo_nuevo"
sleep 2
echo "La nueva lista a sido generada exitosamente!"
#Comprimimos todo lo generado en un unico .zip
cd $direccion_script
#zip -r todo.zip . -i imagenes/*
find imagenes -name "*.jpg" | zip -@ todo.zip
chmod 777 todo.zip
sleep 1
echo "Todo a sido comprimido exitosamente!"
