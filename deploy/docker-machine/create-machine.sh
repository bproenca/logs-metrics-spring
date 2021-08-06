#!/bin/bash

docker-machine create -d virtualbox --virtualbox-memory 6144 swarm-1

for i in 2 3; do
  docker-machine create -d virtualbox swarm-$i
done

eval "$(docker-machine env swarm-1)"

docker swarm init --advertise-addr $(docker-machine ip swarm-1)

docker-machine ssh swarm-1 "sudo mkdir -p /data/elasticsearch/data && sudo chown -R 1000.1000 /data"
docker-machine ssh swarm-1 "echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
docker-machine ssh swarm-1 "sudo mkdir -p /data/prometheus/data && sudo chown -R 1000.1000 /data"
docker-machine ssh swarm-1 "sudo mkdir -p /data/grafana/data && sudo chown -R 1000.1000 /data"

JOIN_TOKEN=$(docker swarm join-token -q worker)

for i in 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker swarm join --token $JOIN_TOKEN \
        --advertise-addr $(docker-machine ip swarm-$i) \
        $(docker-machine ip swarm-1):2377
done

eval "$(docker-machine env swarm-1)"
