#!/usr/bin/env bash

if [ $# != 2 ]; then
    echo "usage: $0 IN_A.csv OUT_B.csv"
    exit 1
fi

sort $1 > $2
