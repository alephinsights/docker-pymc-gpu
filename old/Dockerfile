FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ENV TZ=Europe/London

RUN apt-get update && apt-get upgrade -y -qq && \
    apt-get install -y curl python3 python3-pip python3-dev python3-setuptools && \
    DEBIAN_FRONTEND="noninteractive" \apt-get install -y \
        build-essential \
        wget \
        git \
        curl \
        unzip \
        nano && \
    apt-get autoremove && apt-get clean && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

# Install things definily needed
RUN pip install --upgrade pip --no-cache-dir
# RUN pip install jupyter --no-cache-dir

ADD requirements.txt /tmp
RUN pip3 install -r /tmp/requirements.txt --no-cache-dir

ENV CUDA_HOME /usr/local/cuda
ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]