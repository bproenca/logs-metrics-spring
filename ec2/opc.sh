## Docker volumes

/var/lib/docker/containers >>> /d/docker/containers
/var/lib/docker >> /d/docker

## All nodes

sudo usermod -a -G docker opc

sudo mkdir /d/storage
sudo chown -R opc:opc /d/storage/

mkdir -p /d/storage/filebeat/data

cat /opt/update-firewall.sh

sudo firewall-cmd --permanent --zone=public --add-port=2376/tcp
sudo firewall-cmd --permanent --zone=public --add-port=2377/tcp
sudo firewall-cmd --permanent --zone=public --add-port=7946/tcp
sudo firewall-cmd --permanent --zone=public --add-port=7946/udp
sudo firewall-cmd --permanent --zone=public --add-port=4789/udp

sudo firewall-cmd --permanent --zone=public --add-port=2377/tcp
sudo firewall-cmd --permanent --zone=public --add-port=5601/tcp
sudo firewall-cmd --permanent --zone=public --add-port=3000/tcp
sudo firewall-cmd --permanent --zone=public --add-port=9090/tcp
sudo firewall-cmd --permanent --zone=public --add-port=9200/tcp
sudo firewall-cmd --permanent --zone=public --add-port=9100/tcp

https://www.digitalocean.com/community/tutorials/how-to-configure-the-linux-firewall-for-docker-swarm-on-ubuntu-16-04

## Node 2 (manager)

docker swarm init

docker network create -d overlay monitor
docker network create -d overlay app-network

docker config create prometheus.yml deploy/prometheus.yml
docker config create filebeat.yml deploy/filebeat.yml

mkdir -p /d/storage/elasticsearch/data
mkdir -p /d/storage/prometheus/data
mkdir -p /d/storage/grafana/data

## Node 1 e 3 (workers)

docker swarm join --token SWMTKN-1-5sw8lxjc3nczgus3rw60hdrqw13sd95320h6awa6ba7gnnwqrn-8ovvlifavh5ljgkzify8vqoyf 172.19.30.215:2377

