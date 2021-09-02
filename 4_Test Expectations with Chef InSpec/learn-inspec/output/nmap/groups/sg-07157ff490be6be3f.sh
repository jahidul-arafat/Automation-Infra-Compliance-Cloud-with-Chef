#!/bin/sh

set -e

# -sT look for connect success
# -sV, --version-all look for versions of services
# -T2 relatively slow
nmap -oX /opt/sgCheckup/results/sg-07157ff490be6be3f.xml -Pn -sT -sV --version-light -T2 -p T:7575 52.55.22.138 52.70.229.165 18.211.142.157
