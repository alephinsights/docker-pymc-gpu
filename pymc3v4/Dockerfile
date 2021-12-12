FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04

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
        git \
        nano && \
    apt autoremove && apt clean

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN git clone https://github.com/pymc-devs/pymc/ /tmp/pymc

RUN conda env create -f /tmp/pymc/conda-envs/environment-test-py39.yml

RUN echo "conda activate pymc-test-py39" >> ~/.bashrc
RUN conda init bash
SHELL ["/bin/bash", "--login", "-c"]
RUN cd /tmp/pymc && pip install .

# install things we definitly need
RUN conda install -c conda-forge jupyterlab && \
    conda clean -a -y

# install things we definitly need
RUN conda install -c conda-forge pygpu && \
    conda clean -a -y

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

RUN echo "conda activate pymc-test-py39" >> /home/jupyter/.bashrc
RUN conda init bash

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]