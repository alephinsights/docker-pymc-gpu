FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ENV TZ=Europe/London

RUN apt update && apt upgrade -y -qq && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        build-essential \
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
RUN conda install -c conda-forge pymc3==3.8 mkl mkl-service jupyterlab && \
    conda clean -a -y

RUN conda install pygpu==0.7.6 && \
    conda clean -a -y

RUN conda install theano-pymc==1.1.2 && \
    conda clean -a -y

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]