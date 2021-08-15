# Intro

Centralized Logs and Metrics with Spring Boot 

## Build Java App

```
mvn clean package
docker build -t bproenca/logs-metrics-spring .
docker login
docker push bproenca/logs-metrics-spring:latest
```

## Machines

See `create-machine.sh` file.

## Networks

```
eval "$(docker-machine env swarm-1)"
docker network create -d overlay monitor
docker network create -d overlay app-network
```

## Deploy

```
docker config create logstash.conf deploy/logstash.conf
docker config create prometheus.yml deploy/prometheus.yml

docker stack deploy -c deploy/logging-stack.yml logging
docker stack deploy -c deploy/api-stack.yml api
docker stack deploy -c deploy/exporters-stack.yml exporter
docker stack deploy -c deploy/monitoring-stack.yml monitoring


docker stack ps -f desired-state=running logging
docker stack ps -f desired-state=running monitoring
docker stack ps -f desired-state=running api
```

## Links

* https://dev.to/anandsunderraman/json-logging-in-spring-boot-applications-2j33
* https://discuss.elastic.co/t/kibana-quering-inside-message-body-having-field-json-object-type/179722/2