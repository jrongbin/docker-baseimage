#!/usr/bin/env ruby
require './tool'

dpkgs = %w( git-core htop screen apt-transport-https vim rsync libmysqlclient-dev mysql-client bzip2 libfontconfig )

result = %q(
FROM ruby:2.3

RUN apt-get update

{{debian_dpkgs}}

{{supervisor}}

{{ssh_server}}

{{cron_server}}

{{nginx_server}}

{{node6_lts}}

{{locale}}

{{timezone}}

{{ssh_agent}}

{{debian_clean}}

{{dotbashrc}}

RUN mkdir /app
WORKDIR /app
VOLUME /app

EXPOSE 22 80

CMD ["sh", "-c", "env > /etc/environment ; /usr/bin/supervisord"]
)

save(result, 'ruby2.3-lts/Dockerfile')
