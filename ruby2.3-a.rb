#!/usr/bin/env ruby
require './tool'

node_version ='6.9.4'
dpkgs = %w( git-core vim htop screen apt-transport-https )

result = %q(
FROM ruby:2.3

{{debian_dpkgs}}

{{supervisor}}

{{ssh_server}}

{{cron_server}}

{{nginx_server}}

{{node6}}

{{yarn}}

{{locale}}

{{timezone}}

{{ssh_agent}}

{{debian_clean}}

RUN set -ex \
  && { \
    echo 'export TERM=xterm'; \
  } >> /root/.bashrc

RUN mkdir /app
WORKDIR /app
VOLUME /app

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
)

save(result, 'ruby2.3-a/Dockerfile')
