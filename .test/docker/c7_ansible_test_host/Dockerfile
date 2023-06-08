FROM centos:centos7.9.2009

RUN yum update -y glibc-common
RUN yum install -y sudo openssh-server openssh-clients epel-release
RUN yum install -y sshpass

RUN (ssh-keygen -A; \
     sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config; \
     sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/CentOS-Base.repo)

RUN (mkdir -p /root/.ssh/; \
     rm -f /var/lib/rpm/.rpm.lock; \
     echo "StrictHostKeyChecking=no" > /root/.ssh/config; \
     echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config)

RUN groupadd -g 1000 user
RUN useradd -d /home/user -s /bin/bash -m user -u 1000 -g 1000

RUN groupadd -g 1003 test_user
RUN useradd -d /home/test_user -s /bin/bash -m test_user -u 1003 -g 1003

RUN groupadd sudo
RUN usermod -aG sudo user

RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "root:root" | chpasswd
RUN echo "user:user" | chpasswd

USER root

EXPOSE 22
EXPOSE 8080
EXPOSE 8090
EXPOSE 8000
EXPOSE 80
EXPOSE 443

# systemd replacement script
# source: https://github.com/gdraheim/docker-systemctl-replacement/tree/master
COPY systemctl.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

RUN systemctl enable sshd

ENTRYPOINT /usr/sbin/sshd -D
CMD /usr/bin/systemctl