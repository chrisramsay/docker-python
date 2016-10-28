FROM python:2.7
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

ENV HOME /root

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="2016-10-28T11:31:57Z" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for programming with Python" \
      org.label-schema.url="https://github.com/chrisramsay/docker-python" \
      org.label-schema.vcs-ref="3379c489e73282659484f5fa7e7ca5eae8acf805" \
      org.label-schema.vcs-url="git@github.com:chrisramsay/docker-python.git" \
      org.label-schema.vendor="Chris Ramsay" \
      org.label-schema.version="0.1.0" \
      org.label-schema.schema-version="1.0"

RUN apt-get -y update && apt-get install -y \
python \
python-dev \
python-pip \
git

WORKDIR /srv
ADD ./requirements.txt /srv/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ADD files/jupyter.sh /srv/jupyter.sh
ADD files/bashrc /root/.bashrc
RUN chmod 700 /srv/jupyter.sh
