#!/bin/bash
route -n | awk '/UG[ \t]/{print $2}' >> /tmp/hostip
cat /tmp/hostip >> /etc/hosts
cp /etc/hosts /tmp/hosts.new
sed -i '${s/$/ dockerhost/}' /tmp/hosts.new
cp -f /tmp/hosts.new /etc/hosts
