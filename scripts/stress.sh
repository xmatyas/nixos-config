#! /usr/bin/env bash
for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done
