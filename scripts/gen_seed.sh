#!/usr/bin/env bash

if [ $# != 1 ]; then
    echo "usage: $0 seed.txt"
    exit 1
fi
ruby -e 'puts rand(10**20)' > $1
