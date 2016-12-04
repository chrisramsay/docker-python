FROM python:2.7
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
python \
python-dev \
python-pip \
git

# Upgrade and install Python packages
WORKDIR /srv
ADD ./requirements.txt /srv/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Shell bits
ADD files/bashrc /root/.bashrc
ADD build/VERSION /root/VERSION

# Some bits to get Jupyter working
RUN mkdir /root/.jupyter
ADD files/jupyter.sh /srv/jupyter.sh
ADD files/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN chmod 700 /srv/jupyter.sh
RUN jupyter nbextensions_configurator enable --user
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter contrib nbextension install --user
