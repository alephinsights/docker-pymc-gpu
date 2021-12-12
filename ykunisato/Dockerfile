# https://hub.docker.com/r/ykunisato/ccp-lab-j/dockerfile
FROM ykunisato/ccp-lab-j:latest

RUN conda install -y -c conda-forge mkl mkl-service && \
    conda clean -a -y

RUN conda install -y -c conda-forge gcc_linux-64 && \
    conda clean -a -y

RUN pip install pygpu --no-cache-dir

USER root
RUN apt-get update && apt-get upgrade -y -qq && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y gcc g++ build-essential && \
    apt-get autoremove && apt-get clean
    
ENV PATH=/usr/bin/gcc:$PATH