# ansible-docker

This Ansible playground has been set up with Docker images using centos7 latest image. systemd and sshd services are enbled. An ssh key pair is created automatically in order for the ansible control node to communicate with the remote nodes. 

A docker-compose file is utilzed to bring up all three containers and mount the ssh key pairs in their respective locations. 

A Makefile is used for building the Docker image, bringing up the services, creating an ssh key pair and the removal a file `docker exec -it r-host-1 rm /run/nologin` because of Docker lack of tmpfs support.
<br><br>
https://github.com/CentOS/sig-cloud-instance-images/issues/60

### Nodes
```
c-host: Control Node
r-host-1: Remote Node
r-host-2: Remote Node
```

### Instructions
1. Create an ssh key pair and use default `id_rsa` name
```
ssh-keygen
```
2. Run Make to bring up all 3 nodes
```
make
```
3. SSH into control host
```
docker exec -it c-host bash
```
4. Test connections to nodes
```
ansible servers -m setup
```
### Test
#### Run Playbook
```
ansible-playbook playbooks/latest-httpd.yml
```
#### Run Adhoc Task
```
ansible servers -m shell -a "hostname -I"
```
