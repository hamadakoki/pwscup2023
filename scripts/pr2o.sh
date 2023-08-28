#!/usr/bin/env bash

if [ $# != 3 ]; then
    echo "usage: $0 IN_P.csv IN_R.csv OUT_O.csv"
    exit 1
fi

paste -d, $1 $2 > $3
