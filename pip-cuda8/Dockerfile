FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ENV TZ=Europe/London

RUN apt-get update && apt-get upgrade -y -qq && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        build-essential \
        wget \
        git \
        curl \
        unzip \
        nano && \
    apt-get autoremove && apt-get clean

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Install things definily needed
RUN conda install -c conda-forge jupyterlab && \
    conda clean -a -y

ADD requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt --no-cache-dir

RUN conda install -c conda-forge pygpu==0.7.6 && \
    conda clean -a -y

ENV CUDA_HOME /usr/local/cuda
ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]