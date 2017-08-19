FROM ubuntu:16.04

RUN apt-get update

# DEBIAN_DPKGS BEGIN
RUN apt-get install -y --no-install-recommends ca-certificates curl wget gdebi-core mime-support

# DEBIAN_DPKGS END

# SUPERVISOR BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends supervisor \
  && mkdir -p /var/log/supervisor \
  && { \
    echo '[supervisord]'; \
    echo 'nodaemon=true'; \
  } >> /etc/supervisor/conf.d/supervisord.conf

# SUPERVISOR END

RUN set -ex \
  && wget -O /tmp/ossfs.deb "http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/32196/cn_zh/1496671459961/ossfs_1.80.2_ubuntu16.04_amd64.deb" \
  && gdebi -n /tmp/ossfs.deb \
  && touch /etc/passwd-ossfs \
  && chmod 640 /etc/passwd-ossfs \
  && mkdir /tmp/ossfs \
  && rm /tmp/ossfs.deb

# DEBIAN_CLEAN BEGIN
RUN set -ex \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# DEBIAN_CLEAN END

CMD ["sh", "-c", "echo $BUCKET_NAME:$ACCESS_KEY_ID:$ACCESS_KEY_SECRET > /etc/passwd-ossfs ; ossfs $BUCKET_NAME /tmp/ossfs -ourl=$OSS_ENDPOINT ; /usr/bin/supervisord"]