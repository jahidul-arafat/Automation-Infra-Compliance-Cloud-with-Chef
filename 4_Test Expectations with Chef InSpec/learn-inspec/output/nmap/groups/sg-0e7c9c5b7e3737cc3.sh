#!/bin/sh

set -e

# -sT look for connect success
# -sV, --version-all look for versions of services
# -T2 relatively slow
nmap -oX /opt/sgCheckup/results/sg-0e7c9c5b7e3737cc3.xml -Pn -sT -sV --version-light -T2 -p T:6666 34.192.141.195
