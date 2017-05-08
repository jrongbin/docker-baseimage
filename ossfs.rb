#!/usr/bin/env ruby
require './tool'

dpkgs = %w( gdebi-core )

result = %q(
FROM ubuntu:16.04

RUN apt-get update

{{debian_dpkgs}}

{{supervisor}}

RUN set -ex \
  && wget -O /tmp/ossfs.deb "http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/32196/cn_zh/1483608175067/ossfs_1.80.0_ubuntu16.04_amd64.deb" \
  && apt-get install /tmp/ossfs.deb \
  && touch /etc/passwd-ossfs \
  && chmod 640 /etc/passwd-ossfs \
  && mkdir /tmp/ossfs \
  && rm /tmp/ossfs.deb

{{debian_clean}}

CMD ["sh", "-c", "ossfs my-bucket /tmp/ossfs -ourl=$OSS_ENDPOINT ; /usr/bin/supervisord"]
)

save(result, 'ossfs/Dockerfile')
