#TP-Environments
Final Practical Work - Image Processing
This is the final practical work, in which a program to process images must be designed and written. The program consists of several main parts: generation and download of images, decompression of images, transformation of the size of the images and generation of two text files, one with the name of all the generated people, and another with the name of the people that ends with the letter "a", and finally a compressed file with everything.

Previous requirements
Before starting, you must have the following installed:

Docker - Container Platform
Git - Have an account to save the repo locally
Environment configuration:
Clone this repository to your local machine:

git clone https://github.com/aguneirotti/TP-Entornos

We move to the local repo:

cd TP-Environments

Program usage:

The program will run inside a Docker container. Below are the steps to build the image and run the container.

Build the Docker image:

sudo docker build -t tp_container .

Run the container:

sudo docker run -it --rm tp_container
This will start the program and display the main menu to select options.

Main menu
Inside the container, a menu is presented that allows you to select the different program options. Below are the available options:

Generate and download images.
Unzip images.
Process images.
Compress images.
Select an option by entering the corresponding number and follow the instructions presented to you in each case.

AUTHOR: Agustin Neirotti
