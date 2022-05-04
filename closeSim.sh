#!/bin/bash
sim=$(pidof PlaydateSimulator)

if [ -n "$sim" ]; then
    kill -9 $sim 
else
    exit 0
fi