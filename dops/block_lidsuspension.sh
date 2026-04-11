#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Define the file path
logind_conf="/etc/systemd/logind.conf"

# Perform the changes using sed
sed -i 's/#HandleSuspendKey=suspend/HandleSuspendKey=ignore/' "$logind_conf"
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' "$logind_conf"
sed -i 's/#HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=ignore/' "$logind_conf"

echo "Changes have been made to $logind_conf"

