# ansible-docker

Three centos7 with systemd and sshd services enbled.
```
c-host: Control Node
r-host-1: Remote Node
r-host-2: Remote Node
```

Instructions<br>
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
