FROM continuumio/miniconda3

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

# install things we definitly need
RUN conda install -c conda-forge jupyterlab && \
    conda clean -a -y

# Messing around with various versions of pymc3 etc
# v3.11.3 needed for jax https://discourse.pymc.io/t/confusion-between-latest-release-version-and-development-version-of-pymc/8098
# pymc3=3.11.2 theano-pymc
RUN conda install -c conda-forge python=3.8 mkl mkl-service && \
    conda clean -a -y

RUN pip install -U --no-deps git+https://github.com/pymc-devs/Theano-PyMC.git && \
    pip uninstall typing -y && \
    pip install -U --no-deps git+https://github.com/pymc-devs/pymc3.git@pymc3jax && \
    pip install xarray==0.16.0 -U --no-cache-dir && \
    pip install jax --no-cache-dir && \
    pip install --no-cache-dir jaxlib

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter/work

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]