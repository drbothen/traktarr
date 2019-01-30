FROM python:3.7.2-alpine3.8

# Arguments for build tracking
ARG BRANCH=
ARG COMMIT=

ENV \
  APP_DIR=traktarr \
  TRAKTARR_CONFIG=/config/config.json \
  TRAKTARR_LOGFILE=/config/traktarr.log \
  LC_ALL=C.UTF-8 \
  LANG=C.UTF-8

RUN \
  apk update && apk upgrade && \
  apk add --no-cache bash git openssh && \
  git clone https://github.com/l3uddz/traktarr && \
  chown -R 0:0 traktarr && \
  cd traktarr && \
  python3 -m pip install -r requirements.txt && \
  cd .. && \
  ln -s /traktarr/traktarr.py /usr/local/bin/traktarr
  

# Change directory
WORKDIR /${APP_DIR}

# Config volume
VOLUME /config

# Entrypoint
ENTRYPOINT ["python", "traktarr.py"]
