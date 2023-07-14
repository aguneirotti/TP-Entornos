# TP-Entornos
Trabajo Práctico Final - Procesamiento de imágenes
Este es el trabajo práctico final, en el cual se debe diseñar y escribir un programa para procesar imágenes. El programa consta de varias partes principales: generación y descarga de imágenes, descomprension de imagenes, transformación del tamaño de las imagenes y generación de dos archivos de texto, uno con el nombre de todas las personas generadas, y otro con el nombre de las personas que termina con la letra "a" , y por ultimo un archivo comprimido con todo.

Requisitos previos
Antes de comenzar, hay que tener instalado lo siguiente:

Docker - Plataforma de contenedores
Git - Poseer una cuenta para guardar el repo de forma local
Configuración del entorno: 
Clona este repositorio en tu máquina local: git clone https://github.com/aguneirotti/TP-Entornos
Nos movemos al repo local:
cd TP-Entornos
Uso del programa
El programa se ejecutará dentro de un contenedor Docker. A continuación, se describen los pasos para construir la imagen y ejecutar el contenedor.

Construir la imagen Docker:

sudo docker build -t contenedor_tp .

Ejecutar el contenedor:

sudo docker run -it --rm contenedor_tp
Esto iniciará el programa y mostrara el menú principal para seleccionar las opciones.

Menú principal
Dentro del contenedor, se presenta un menú que te permite seleccionar las diferentes opciones del programa. A continuación, se detallan las opciones disponibles:

Generar y descargar imágenes.
Descomprimir imágenes.
Procesar imágenes.
Comprimir imágenes.
Selecciona una opción ingresando el número correspondiente y sigue las instrucciones que se te presenten en cada caso.

