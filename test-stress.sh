#!/bin/bash
for i in {1..100} 
do
    curl localhost:8080/log
    curl localhost:8080/slowApi
    curl localhost:8080/cpuLoad
    curl localhost:8080/throwError    
done