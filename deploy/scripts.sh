eval "$(docker-machine env swarm-1)"

docker-machine ssh swarm-1 "sudo mkdir -p /data/elasticsearch/data sudo chown -R 1000.1000 /data"

docker network create -d overlay monitor

docker stack deploy -c logging-stack.yml logging

docker stack ps -f desired-state=running logging

curl $(docker-machine ip swarm-1):9200

# Update docker stack and run elasticsearch in private network
docker stack deploy -c logging-stack.yml logging

# ----------------------

eval "$(docker-machine env swarm-1)"

docker network create -d overlay monitor

docker stack deploy -c logging-stack.yml logging

docker stack ps -f desired-state=running logging

echo '
input {
  syslog { port => 51415 }
}
output {
  elasticsearch {
    hosts => ["http://elasticsearch:9200"]
  }
  stdout {
    codec => rubydebug
  }
}
' | docker config create logstash.conf -

docker stack deploy -c logging-stack.yml logging

docker service create \
--name logger-test \
--network monitor \
debian \
bash -c "while true; do logger -n logstash -P 51415 hello world bcp; echo \"Calling Logstash\"; sleep 2;  done"


docker stack ps -f desired-state=running logging

docker service rm logging_logstash

docker config rm logstash.conf

echo '
input {
  syslog { port => 51415 }
}
output {
  elasticsearch {
    hosts => ["http://elasticsearch:9200"]
  }
}
' | docker config create logstash.conf -


docker stack deploy -c logging-stack.yml logging

docker stack ps -f desired-state=running logging


# ----------------------

eval "$(docker-machine env swarm-1)"

docker stack ps -f desired-state=running logging

docker stack deploy -c logging-stack.yml logging

docker stack ps -f desired-state=running logging

docker-machine ip swarm-1


# ----------------------

eval "$(docker-machine env swarm-1)"

docker stack deploy -c logging-stack.yml logging

docker stack ps -f desired-state=running logging


# ----------------------

eval "$(docker-machine env swarm-1)"

docker network create -d overlay names-demo

docker secret create config.yml config.yml

docker stack deploy -c api-stack.yml api

docker stack ps -f desired-state=running api

# ----------------------

while true; do curl -i $(docker-machine ip swarm-1):8080/health;  sleep 2;  done

while true; do curl -i $(docker-machine ip swarm-1):8080/errors;  sleep 2;  done

# ----------------------

# ----------------------

# ----------------------