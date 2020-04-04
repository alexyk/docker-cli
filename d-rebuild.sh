#!/bin/bash

# Rebuild Image
docker rmi -f $1
docker build -t $1 .