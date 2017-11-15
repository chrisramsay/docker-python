FROM python:latest
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

ENV HOME /root

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="r_BUILD_DATE" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for programming with Python" \
      org.label-schema.url="https://github.com/chrisramsay/docker-python" \
      org.label-schema.vcs-ref="r_VCS_REF" \
      org.label-schema.vcs-url="r_VCS_URL" \
      org.label-schema.vendor="Chris Ramsay" \
      org.label-schema.version="r_VERSION" \
      org.label-schema.schema-version="1.0"

# Update and install some stuff
RUN apt-get -y update && apt-get install -y \
    git \
    pandoc

# Upgrade and install Python packages
WORKDIR /srv
ADD conda_envs/root.txt /srv/root.txt
ADD conda_envs/py27.txt /srv/py27.txt
ADD conda_envs/py36.txt /srv/py36.txt

RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b && \
    rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=${PATH}:/miniconda/bin

RUN conda update -yq conda && \
    conda install jupyter && \
    conda install -c conda-forge jupyter_nbextensions_configurator && \
    conda install -c conda-forge jupyter_contrib_nbextensions

RUN conda create -n py27 python=2.7 --file /srv/py27.txt && \
    /bin/bash -c "source activate py27" && \
    /miniconda/envs/py27/bin/ipython kernel install --user

RUN conda create -n py36 python=3.6 --file /srv/py36.txt && \
    /bin/bash -c "source activate py36" && \
    /miniconda/envs/py36/bin/ipython kernel install --user

# Shell bits
ADD files/bashrc /root/.bashrc
ADD build/VERSION /root/VERSION

# Some bits to get Jupyter working
RUN mkdir /root/.jupyter
ADD files/jupyter.sh /srv/jupyter.sh
ADD files/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN chmod 700 /srv/jupyter.sh
