FROM nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu20.04

ENV TZ=Europe/London

RUN apt update && apt upgrade -y -qq && \
    apt install -y curl python3 python3-pip python3-dev python3-setuptools && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        build-essential \
        wget \
        git \
        curl \
        unzip \
        nano && \
    apt autoremove && apt clean && \
    ln -s /usr/bin/python3 /usr/bin/python

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y openjdk-11-jdk \ 
    ca-certificates-java && \
    update-ca-certificates -f && \
    apt-get autoclean && apt-get clean

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda install -c conda-forge pymc3 theano-pymc mkl mkl-service jupyterlab pygpu && \
    conda clean -a -y

RUN conda install pygpu && \
    conda clean -a -y

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

ADD .theanorc /home/jupyter

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]