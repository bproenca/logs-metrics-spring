#!/bin/bash

docker-machine create -d virtualbox --virtualbox-memory 6144 swarm-1

for i in 2 3; do
  docker-machine create -d virtualbox swarm-$i
done

eval "$(docker-machine env swarm-1)"
docker swarm init --advertise-addr $(docker-machine ip swarm-1)
JOIN_TOKEN=$(docker swarm join-token -q worker)

for i in 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker swarm join --token $JOIN_TOKEN \
        --advertise-addr $(docker-machine ip swarm-$i) \
        $(docker-machine ip swarm-1):2377
done

eval "$(docker-machine env swarm-1)"
echo "Creating dirs (node manager)"
docker-machine ssh swarm-1 "whoami"
docker-machine ssh swarm-1 "sudo mkdir -p /data/elasticsearch/data && sudo chown -R 1000.1000 /data"
docker-machine ssh swarm-1 "echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
docker-machine ssh swarm-1 "sudo mkdir -p /data/prometheus/data && sudo chown -R 1000.1000 /data"
docker-machine ssh swarm-1 "sudo mkdir -p /data/grafana/data && sudo chown -R 1000.1000 /data"
docker-machine ssh swarm-1 "ls -la /data"

echo "Pull global images"
for i in 1 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker pull google/cadvisor:latest
    docker pull basi/node-exporter:v1.13.0
    docker pull gliderlabs/logspout:v3.2.3
done

echo "Pull worker images"
for i in 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker pull bproenca/logs-metrics-spring:latest
    docker pull docker.elastic.co/logstash/logstash:5.6.1
    docker pull docker.elastic.co/kibana/kibana:5.6.1
done

echo "Pull manager images"
eval "$(docker-machine env swarm-1)"
docker pull docker.elastic.co/elasticsearch/elasticsearch:5.6.1
docker pull prom/prometheus:v1.7.2
docker pull grafana/grafana:4.5.2


