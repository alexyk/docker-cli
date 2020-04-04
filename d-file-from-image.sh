#!/bin/bash

docker run -v \
  $HOME/.docker/docker.sock:/var/run/docker.sock \
  --rm \
  centurylink/dockerfile-from-image