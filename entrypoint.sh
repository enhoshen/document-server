#!/bin/bash
set -e

# nginx service, daemon
nginx -p ./ -c nginx.conf

# ssh service, daemon
/etc/init.d/ssh start

exec "$@"
