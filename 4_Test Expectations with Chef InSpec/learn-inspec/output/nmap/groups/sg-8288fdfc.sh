#!/bin/sh

set -e

# -sT look for connect success
# -sV, --version-all look for versions of services
# -T2 relatively slow
nmap -oX /opt/sgCheckup/results/sg-8288fdfc.xml -Pn -sT -sV --version-light -T2 -p T:4444 34.224.235.1
