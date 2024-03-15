#!/bin/bash

echo "Running..."
if [ -z "$1" ]; then
 docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze 
fi

if [ "$1" == '-d' ]; then
 docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze -e duplication -f json > /tmp/codeclimate.json &&
  echo "Opening JSON..."
  jless /tmp/codeclimate.json 
fi


if [ "$1" == '-c' ]; then
 docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze -e structure -f json > /tmp/codeclimate.json &&
  echo "Opening JSON..."
  jless /tmp/codeclimate.json 
fi
  

if [ "$1" == '-e' ]; then
 docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze -e eslint -f json > /tmp/codeclimate.json &&
  echo "Opening JSON..."
  jless /tmp/codeclimate.json 
fi


