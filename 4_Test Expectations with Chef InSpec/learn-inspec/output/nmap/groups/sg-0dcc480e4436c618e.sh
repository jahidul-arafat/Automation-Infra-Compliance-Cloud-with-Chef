#!/bin/sh

set -e

# -sT look for connect success
# -sV, --version-all look for versions of services
# -T2 relatively slow
nmap -oX /opt/sgCheckup/results/sg-0dcc480e4436c618e.xml -Pn -sT -sV --version-light -T2 -p T:3306 3.80.59.223
