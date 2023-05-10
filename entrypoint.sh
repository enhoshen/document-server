#!/bin/bash
set -e

nginx -p ./ -c nginx.conf
/etc/init.d/ssh start

top $@

exec "$@"
