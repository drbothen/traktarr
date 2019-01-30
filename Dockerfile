FROM ubuntu

# Arguments for build tracking
ARG BRANCH=
ARG COMMIT=

ENV \
  APP_DIR=/opt/traktarr \
  TRAKTARR_CONFIG=/config/config.json \
  TRAKTARR_LOGFILE=/config/traktarr.log \
  LC_ALL=C.UTF-8 \
  LANG=C.UTF-8

COPY . /${APP_DIR}

RUN \
  apt update && \
  apt install vim git python3 python3-pip && \
  cd /opt && \
  git clone https://github.com/l3uddz/traktarr && \
  chown -R 0:0 traktarr && \
  cd traktarr && \
  python3 -m pip install -r requirements.txt && \
  ln -s /opt/traktarr/traktarr.py /usr/local/bin/traktarr
  

# Change directory
WORKDIR /${APP_DIR}

# Config volume
VOLUME /config

# Entrypoint
ENTRYPOINT ["python", "traktarr.py"]
