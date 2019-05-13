#/bin/bash
sleep 10
export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}') && echo "$DOCKER_HOST_IP dockerhost" >> /etc/hosts
