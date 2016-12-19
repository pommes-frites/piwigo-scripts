#!/bin/bash

basedir=$(dirname "$0")

[[ -d "$basedir"/log ]] || mkdir "$basedir"/log 

"$basedir"/checkAndUpdatePiwigo.sh &> "$basedir"/log/$(date +%Y%m%d_%H%M%S).log
