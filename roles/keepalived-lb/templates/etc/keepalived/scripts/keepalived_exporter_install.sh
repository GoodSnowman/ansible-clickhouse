#!/bin/bash

VERSION="1.2.0"

wget https://nexus-dev.t1.cloud/repository/exporters/keepalived_exporter/keepalived_exporter.service &&
wget https://nexus-dev.t1.cloud/repository/exporters/keepalived_exporter/v$VERSION/keepalived_exporter &&

mv keepalived_exporter /usr/local/bin/keepalived_exporter &&
chmod +x /usr/local/bin/keepalived_exporter

useradd -M -N -s /usr/sbin/nologin keepalived

mv keepalived_exporter.service /etc/systemd/system/keepalived_exporter.service &&
chown root:root /etc/systemd/system/keepalived_exporter.service &&

systemctl daemon-reload &&
systemctl start keepalived_exporter &&
systemctl enable keepalived_exporter &&
systemctl status keepalived_exporter &&

curl 127.0.0.1:9165/metrics &&
service keepalived_exporter status &&

rm -rf keepalived_exporter_install.sh &&

echo "Exporter successfully installed and working"
