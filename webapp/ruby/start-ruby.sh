#!/bin/bash
set -ex

# if [ -d /home/isucon/tmp/ruby ]; then
#   sudo chown -R $(id -u):$(id -g) /home/isucon/tmp/ruby
# fi

bundle install -j8
exec bundle exec puma -e production -p ${SERVER_APP_PORT:-3000} -w 2
