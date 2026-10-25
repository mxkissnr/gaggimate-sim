#!/bin/sh
# The simulator's web server only listens on the loopback interface (hard-coded
# upstream), so forward the container address to it to make the port publishable.
IP=$(hostname -i | awk '{print $1}')
socat "TCP-LISTEN:8080,bind=${IP},fork,reuseaddr" TCP:127.0.0.1:8080 &

Xvfb :99 -screen 0 1024x768x24 &
sleep 1
export DISPLAY=:99
exec /app/gaggimate-sim
