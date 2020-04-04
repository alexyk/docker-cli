#!/bin/bash

dir="./"

[ $# -gt 1 ] && dir="$2"

# Build Image
docker build -t $1 "$dir"