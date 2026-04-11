#!/bin/bash

# This is script is used for setting up exceptions for firewalls
# Purpose is to allow development servers to test dev hosting on other machines

YOURPORT=3333
PERM="--permanent"
SERV="$PERM --service=devport"

firewall-cmd $PERM --new-service=devport
firewall-cmd $SERV --set-short="Developer ports"
firewall-cmd $SERV --set-description="Developer port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=devport
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
