echo "# Pull global images"
docker pull google/cadvisor:latest
docker pull basi/node-exporter:v1.13.0
docker pull gliderlabs/logspout:v3.2.3

echo "Pull worker images"
docker pull bproenca/logs-metrics-spring:latest
docker pull docker.elastic.co/logstash/logstash:5.6.1
docker pull docker.elastic.co/kibana/kibana:5.6.1

echo "Pull manager images"
docker pull docker.elastic.co/elasticsearch/elasticsearch:5.6.1
docker pull prom/prometheus:v1.7.2
docker pull grafana/grafana:4.5.2
