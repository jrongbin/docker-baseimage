#!/usr/bin/env ruby
require './tool'

node_version ='6.7.0'
nginx_version = '1.11.4-1~jessie'
dpkgs = %w( git-core vim htop )

result = %q(
FROM ruby:2.3.1
# expose 22 80
# Node 6.7.0
# Ngnix 1.11.4
# git-core vim htop

{{debian_dpkgs}}

{{supervisor}}

{{ssh_server}}

{{cron_server}}

{{nginx_server}}

{{node6}}

{{locale}}

{{timezone}}

{{ssh_agent}}

{{debian_clean}}

RUN mkdir /app
WORKDIR /app
VOLUME /app

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
)

save result, 'ruby2.3-a/Dockerfile' do
  `cd ruby2.3-a && ln -s ../files .`
end
