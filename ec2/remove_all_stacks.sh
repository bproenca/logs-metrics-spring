#!/bin/bash
docker stack rm api
docker stack rm logging
docker stack rm monitoring
docker stack rm exporter