# docker-spark-datascience

Spark, Jupyterlab, and other Data Science tooling via Docker Swarm

## Setup

https://docs.docker.com/engine/swarm/swarm-mode/

```shell
docker swarm init --advertise-addr=192.168.1.166
```

Setup across all nodes using provided token and command

Nodes:

* 192.168.1.166 - VirtualBox (master)
* 192.168.1.171 - Dell XPS (worker)
* 192.168.1.105 - Alienware (worker)
* 192.168.1.124 - Laptop (worker)

https://docs.docker.com/engine/swarm/manage-nodes/
Check the status of the swarm cluster

```shell
docker node ls
```

https://docs.docker.com/engine/swarm/stack-deploy/
https://hub.docker.com/_/registry

```shell
docker service create --name registry --constraint node.role==manager --publish 5000:5000 registry:latest
docker service ls
```

https://hub.docker.com/r/sameersbn/apt-cacher-ng/
Deploy apt-cacher-ng to speed up builds and not re-download packages again

```shell
# persist the downloaded packages here:
sudo mkdir -p /srv/docker/apt-cacher-ng
docker service create --name apt-cacher-ng --mount type=bind,src=/srv/docker/apt-cacher-ng,dst=/var/cache/apt-cacher-ng --constraint node.role==manager --publish 3142:3142 sameersbn/apt-cacher-ng:latest
```

Check out the cache stats: http://localhost:3142/acng-report.html

Download Spark and copy it to `sparkmaster`, `sparkworker`, and `jupyterlab`.

Download livy and copy it to `sparkmaster`.

Build and save the images on the local registry, then deploy:

```shell
./build-deploy.sh
```

Check the status of the stack

```shel
docker stack ls
docker stack services spark
```

Get the full details

```shell
docker stack ps spark --no-trunc
```

Open up the Spark web-ui

http://localhost:8080

Open up the Jupyterlab web-ui

http://localhost:8000

Look at workers as they execute

http://localhost:8081

Look at the submitter

http://localhost:4040

Look at Livy

http://localhost:8998

## Teardown

Bring everything down

```shell
docker stack rm spark
docker swarm leave --force
```

## Updates

Download newer upstream versions by running `./build-deploy.sh`
