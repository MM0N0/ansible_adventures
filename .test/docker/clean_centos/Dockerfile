FROM centos/systemd

RUN yum -y install net-tools rsync sysvinit-tools less sudo openssh-server openssh-clients epel-release
RUN yum -y install ansible
RUN systemctl enable sshd
RUN sed -i '/UsePAM yes/d' /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config

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

CMD ["/usr/sbin/init"]