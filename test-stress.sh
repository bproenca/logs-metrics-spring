#!/bin/bash
for j in {1..5} do
    for i in {1..10} do
        curl localhost:8080/log
        curl localhost:8080/slowApi
        curl localhost:8080/cpuLoad
    done
    curl localhost:8080/throwError    
done