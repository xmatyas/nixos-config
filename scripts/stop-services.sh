#! /usr/bin/env bash
sudo systemctl list-units | grep "podman-.*\.service" | awk '{print $1}' | xargs sudo systemctl stop 
