#!/bin/bash

for i in 3 2 1; do
    eval "$(docker-machine env swarm-$i)"
    docker rmi $(docker images -q bproenca/logs-metrics-spring)
done