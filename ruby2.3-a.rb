#!/usr/bin/env ruby
require './tool'

debian_mirror='mirrors.aliyun.com'
node_version ='6.9.4'
dpkgs = %w( vim )

result = %q(
FROM ruby:2.3

RUN apt-get update

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

{{debian_mirror}}

{{debian_clean}}

{{dotbashrc}}

RUN mkdir /app
WORKDIR /app
VOLUME /app

EXPOSE 22 80 3000
CMD ["/usr/bin/supervisord"]
)

save(result, 'ruby2.3-a/Dockerfile')
