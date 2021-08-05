#!/bin/bash

for i in 3 2 1; do
    docker-machine stop swarm-$i
done