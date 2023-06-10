FROM centos:centos7.9.2009

# install requirements
RUN yum update -y glibc-common
RUN yum install -y sudo openssh-server openssh-clients epel-release
RUN yum install -y sshpass

# setup sshd
RUN (ssh-keygen -A; \
     sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config; \
     sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/CentOS-Base.repo)
RUN (mkdir -p /root/.ssh/; \
     rm -f /var/lib/rpm/.rpm.lock; \
     echo "StrictHostKeyChecking=no" > /root/.ssh/config; \
     echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config)

# add user
RUN groupadd -g 1000 user
RUN useradd -d /home/user -s /bin/bash -m user -u 1000 -g 1000
RUN echo "user:user" | chpasswd

# add user to sudoers
RUN groupadd sudo
RUN usermod -aG sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# set root passwd
RUN echo "root:root" | chpasswd

# systemd replacement script
# source: https://github.com/gdraheim/docker-systemctl-replacement/tree/master
COPY systemctl.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

# expose port 22 and 8080
EXPOSE 22
EXPOSE 8080

# start sshd and init systemd replacement
ENTRYPOINT /usr/sbin/sshd -D
CMD /usr/bin/systemctl
