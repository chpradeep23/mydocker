#!/bin/bash

pkill podman
pkill qemu

podman machine start --log-level debug &
PID=$!
sleep 2

pkill -STOP podman
pkill -STOP gvproxy

echo "^^^^"
echo "^^^^"
echo "^^^^"
echo "If the above says the VM already running or started"
echo "then edit the json file located at ~/.config/containers/podman/machine/qemu/"
echo "and change the line"
echo "\"Starting\": true"
echo "to be"
echo "\"Starting\": false"
echo ""
echo "dont forget to save, and rerun this script."
echo ""
echo "Else, continue with instructions below"
echo ""
echo "Qemu will open in another window (likely in the background)"
echo "wait until you see a login prompt on that window"
read -p "then return to THIS terminal and hit enter"

pkill -CONT podman
pkill -CONT gvproxy
