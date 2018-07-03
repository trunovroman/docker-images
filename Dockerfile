FROM debian:latest

MAINTAINER Trunov Roman <trunovroman@gmail.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing \
    && apt-get upgrade -y

RUN apt-get install -y wget git curl grep dpkg htop bzip2

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda2-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get clean

ENV PATH /opt/conda/bin:$PATH

RUN jupyter notebook --generate-config --allow-root && echo "c.NotebookApp.password = u'sha1:3379fd89793c:4dfb6fd74c64a436b43f30dd33e9a3a68433ce52'" >> ~/.jupyter/jupyter_notebook_config.py

EXPOSE 8899

WORKDIR /home/playground

ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--no-browser", "--port", "8899", "--ip", "'*'"]
