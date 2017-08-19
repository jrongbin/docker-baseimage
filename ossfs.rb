#!/usr/bin/env ruby
require './tool'

dpkgs = %w( gdebi-core mime-support )

result = %q(
FROM ubuntu:16.04

RUN apt-get update

{{debian_dpkgs}}

{{supervisor}}

RUN set -ex \
  && wget -O /tmp/ossfs.deb "http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/32196/cn_zh/1496671459961/ossfs_1.80.2_ubuntu16.04_amd64.deb" \
  && gdebi -n /tmp/ossfs.deb \
  && touch /etc/passwd-ossfs \
  && chmod 640 /etc/passwd-ossfs \
  && mkdir /tmp/ossfs \
  && rm /tmp/ossfs.deb

{{debian_clean}}

CMD ["sh", "-c", "echo $BUCKET_NAME:$ACCESS_KEY_ID:$ACCESS_KEY_SECRET > /etc/passwd-ossfs ; ossfs $BUCKET_NAME /tmp/ossfs -ourl=$OSS_ENDPOINT ; /usr/bin/supervisord"]
)

save(result, 'ossfs/Dockerfile')
