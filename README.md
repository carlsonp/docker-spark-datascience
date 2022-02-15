# docker-spark-datascience

Spark, Jupyterlab, and other Data Science tooling via Docker Swarm

## Setup

https://docs.docker.com/engine/swarm/swarm-mode/

```shell
docker swarm init --advertise-addr=192.168.1.113 --listen-addr=0.0.0.0
```

Setup across all nodes using provided token and command

Nodes:

* 192.168.1.113 - Asus-Blue (master)
* 192.168.1.145 - Windows WSL2 (worker)
* 192.168.1.105 - Alienware (worker)
* 192.168.1.124 - Laptop (worker)

https://docs.docker.com/engine/swarm/manage-nodes/
Check the status of the swarm cluster

```shell
docker node ls
```

https://docs.docker.com/engine/swarm/stack-deploy/

Use existing Docker image registry on Raspberry Pi.

Add the following to your `daemon.json` Docker file:

```file
"insecure-registries": ["192.168.1.226:5000"]
```

```shell
docker service ls
```

Download Spark and copy it to `sparkmaster`, `sparkworker`, and `jupyterlab`.

Download livy and copy it to `sparkmaster`.

Download Spark NLP .jar and copy it to `sparkmaster`, `sparkworker`, and `jupyterlab`.

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

http://localhost:8090

Open up the Jupyterlab web-ui

http://localhost:8888

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

## Debugging

* `nload` - for live network usage
* `htop` - for live CPU and RAM usage
