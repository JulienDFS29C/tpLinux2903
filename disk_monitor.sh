#!/bin/bash

percentage=$(df / --output=pcent | sed -n '2p' | tr -d ' %');

echo "Disk space almost full : $percentage% used";
