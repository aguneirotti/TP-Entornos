FROM ubuntu
RUN apt-get update && apt-get install -y zip unzip imagemagick curl
COPY . /scripts
WORKDIR /scripts
RUN chmod +x menu.sh generar.sh descomprimir.sh comprimir.sh 
CMD ["./menu.sh"]
