FROM centos:7

WORKDIR /root

# sshd service requirements
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

# enable ssh login
RUN yum update -y
RUN yum install vim ansible openssh-clients openssh openssh-server -y
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22

# configure ansible remote hosts
# https://pinrojas.com/2017/03/21/ansible-docker-failed-to-connect-to-new-control-master/
RUN sed -i 's/#ssh_args = -C -o ControlMaster=auto -o ControlPersist=60s/ssh_args = -C -o ControlMaster=auto -o ControlPersist=60s/' /etc/ansible/ansible.cfg
RUN sed -i 's/#control_path =/control_path = \/dev\/shm\/cp%%h-%%h-%%r/' /etc/ansible/ansible.cfg
RUN echo -e "[servers]" >> /etc/ansible/hosts
RUN echo -e "r-host-1\nr-host-2" >> /etc/ansible/hosts

CMD ["/usr/sbin/init"]
