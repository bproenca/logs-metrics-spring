#!/bin/bash
docker stack deploy -c deploy/logging-stack.yml logging
docker stack deploy -c deploy/exporters-stack.yml exporter
docker stack deploy -c deploy/monitoring-stack.yml monitoring
docker stack deploy -c deploy/api-stack.yml api