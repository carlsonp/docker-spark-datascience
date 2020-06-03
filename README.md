# docker-spark-datascience

https://docs.docker.com/engine/swarm/swarm-mode/

```shell
docker swarm init --advertise-addr=192.168.1.166
```

Nodes:

* 192.168.1.166 - VirtualBox (master)
* 192.168.1.171 - Dell XPS (worker)
* 192.168.1.105 - to be replaced (worker)
* 192.168.1.124 - Laptop (worker)

https://docs.docker.com/engine/swarm/manage-nodes/
Check the status of the swarm cluster

```shell
docker node ls
```

https://docs.docker.com/engine/swarm/stack-deploy/
https://hub.docker.com/_/registry

```shell
docker service create --name registry --publish 5000:5000 registry:latest
docker service ls
```

Build and save the images on the local registry, then deploy:

```shell
./build-deploy.sh
```

Check the status of the stack

```shel
docker stack ls
docker stack services spark
```

Open up the Spark web-ui

http://192.168.1.166:8080

Open up the Jupyterlab web-ui

http://192.168.1.166:8000

## Teardown

Bring everything down

```shell
docker stack rm spark
docker swarm leave --force
```

## Updates

Download newer upstream versions

```shell
docker-compose build --pull
```
