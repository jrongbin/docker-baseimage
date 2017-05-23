FROM agideo/ruby:2.3-lts

RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends connect-proxy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
