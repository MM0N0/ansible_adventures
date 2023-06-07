FROM centos:6.7

##########################################################################
### update glibc-common for locale files
RUN yum update -y glibc-common

##########################################################################
# all yum installations here
RUN yum install -y sudo passwd openssh-server openssh-clients tar screen crontabs strace telnet perl libpcap bc patch ntp dnsmasq unzip pax which

##########################################################################
# add epel repository
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN (yum install -y hiera lsyncd sshpass rng-tools)

# start sshd to generate host keys, patch sshd_config and enable yum repos
RUN (service sshd start; \
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
RUN groupadd sudo
RUN usermod -aG sudo user

RUN groupadd -g 1003 test_user
RUN useradd -d /home/test_user -s /bin/bash -m test_user -u 1003 -g 1003

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

CMD service crond start; /usr/sbin/sshd -D
