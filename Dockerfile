#FROM python:3.7-slim as production
FROM ubuntu:20.04 as production
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime

# LABEL about the custom image
LABEL maintainer="rhsu@alumni.cmu.edu"
LABEL version="0.1"
LABEL description="This is custom Docker Image web application"

# Install System and Python software
RUN apt-get update \
  && apt-get install -y python3-pip python3-venv zip unzip vim zsh nano apache2 libapache2-mod-wsgi-py3 \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && pip3 install setuptools wheel 

# ENTRYPOINT ["python3"]
#######################################
ENV PYTHONUNBUFFERED=1
WORKDIR /app/

RUN apt-get update && \
    apt-get install -y \
    bash \
    build-essential \
    gcc \
    libffi-dev \
    musl-dev \
    openssl \
    postgresql \
    libpq-dev 

COPY requirements/prod.txt ./requirements/prod.txt
RUN pip install -r ./requirements/prod.txt

COPY manage.py ./manage.py
#COPY setup.cfg ./setup.cfg
COPY hackershack_website ./hackershack_website

EXPOSE 8000

FROM production as development

COPY requirements/dev.txt ./requirements/dev.txt
RUN pip install -r ./requirements/dev.txt

COPY . .


