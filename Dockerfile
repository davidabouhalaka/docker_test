FROM ubuntu:trusty

RUN apt-get install git -y
#RUN sudo apt-add-repository ppa:ubuntu-desktop/ubuntu-make
RUN sudo apt-get update -y 
RUN sudo apt-get install make -y  
RUN sudo  apt-get install wget -y 
#Install Golang
RUN cd /tmp && \
    wget https://dl.google.com/go/go1.12.2.linux-amd64.tar.gz && \
    tar -xvf go1.12.2.linux-amd64.tar.gz && \
    cp go/bin/go /usr/local/bin && \
    mv go /usr/local

WORKDIR /

RUN git clone https://github.com/hashicorp/consul && \
    cd consul && \
    make tools && \
    make dev

EXPOSE 8500

CMD /consul/bin/consul agent -dev -client 0.0.0.0
