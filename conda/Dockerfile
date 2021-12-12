# FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ENV TZ=Europe/London

RUN apt update && apt upgrade -y -qq && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        build-essential \
        gcc \
        g++ \
        wget \
        git \
        curl \
        unzip \
        nano && \
    apt autoremove && apt clean

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# install things we definitly need
RUN conda install -c conda-forge jupyterlab && \
    conda clean -a -y

# Messing around with various versions of pymc3 etc
RUN conda install -c conda-forge python=3.8 pymc3 theano-pymc mkl mkl-service && \
    conda clean -a -y

RUN conda install pygpu && \
    conda clean -a -y

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]