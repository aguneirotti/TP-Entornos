#!/bin/bash
echo "Final project"
echo "------------------------------------------------------"

chmod +x generar.sh menu.sh comprimir.sh descomprimir.sh procesar.sh

# Define the options given by the program as a list of strings
options=("Generate image" "Decompress" "Process image" "Compress" "Exit")

while [ "$exit_program" = false ]; do
    menu
done

exit_program=false

function menu {
    echo "Select an option:"
    for ((i=0; i<${#options[@]}; i++)); do
        echo "$((i+1)). ${options[$i]}"
    done
    read option
    case $option in 
        1)
            echo "You have selected to generate image"
            sleep 1
            source generar.sh
            ;;
        2) 
            echo "You have selected the decompress option"  
            sleep 1
            source descomprimir.sh
            cd ..
            ;;  
        3)
            echo "You have selected to process images"
            sleep 1
            source procesar.sh
            ;;
        4)
            echo "You have selected to compress"
            sleep 1
            cd ..
            source comprimir.sh
            ;;
        5)
            echo "Exiting the program..."
            sleep 2
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

while [ "$exit_program" = false ]; do
    menu
done
