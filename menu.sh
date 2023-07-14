#!/bin/bash
echo "Trabajo practico final"
echo "------------------------------------------------------"

chmod +x generar.sh menu.sh comprimir.sh descomprimir.sh procesar.sh

#Definimos las opciones que da el programa como una lista compuesta por strings
opciones=("Generar imagen" "Descomprimir" "Procesar imagen" "Comprimir" "Salir")


while [ "$salir" = false ]; do
    menu
done

salir=false

function menu {
    echo "Selecciona una opcion:"
    for ((i=0; i<${#opciones[@]}; i++)); do
        echo "$((i+1)). ${opciones[$i]}"
    done
    read opcion
    case $opcion in 
        1)
            echo "Has seleccionado generar imagen"
            sleep 1
            source generar.sh
            ;;
        2) 
            echo "Has selecciondo la opcion descomprimir"  
            sleep 1
            source descomprimir.sh
            cd ..
            ;;  
        3)
            echo "Has seleccionado procesar imagenes"
            sleep 1
            source procesar.sh
            ;;
        4)
            echo "Has seleccionado comprimir"
            sleep 1
            cd ..
            source comprimir.sh
            ;;
        5)
            echo "Saliendo del programa..."
            sleep 2
            exit 0
            ;;
        *)
            echo "Opcion invalida"
            ;;
    esac
    
}

while [ "$salir" = false ]; do
    menu
done
