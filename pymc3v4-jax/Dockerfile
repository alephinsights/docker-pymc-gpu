FROM nvidia/cuda:11.5.1-cudnn8-runtime-ubuntu20.04

ENV TZ=Europe/London

RUN apt-get update && apt-get upgrade -y -qq && \
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
    apt-get autoremove && apt-get clean

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda create -y --name pymc

RUN echo "conda activate pymc" >> ~/.bashrc
RUN conda init bash
SHELL ["/bin/bash", "--login", "-c"]

# install things we definitly need - just to speed up the build
RUN conda install -y -c conda-forge jupyterlab mamba pip && \
    conda clean -a -y

# mess around installing packages here
# https://www.pymc-labs.io/blog-posts/the-quickest-migration-guide-ever-from-pymc3-to-pymc-v40/
RUN mamba install -y -c conda-forge pymc && \
    conda clean -a -y

RUN pip3 install numpy scipy six wheel jaxlib==0.3.0+cuda11.cudnn82 -f https://storage.googleapis.com/jax-releases/jax_releases.html jax[cuda11_cudnn82] -f https://storage.googleapis.com/jax-releases/jax_releases.html

RUN pip3 install aeppl==0.0.17 numpyro 

RUN pip3 install --upgrade "jax[cuda]" -f https://storage.googleapis.com/jax-releases/jax_releases.html  # Note: wheels only available on linux.


RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

RUN echo "conda activate pymc" >> /home/jupyter/.bashrc
RUN conda init bash

ADD .aesararc /home/jupyter/

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]