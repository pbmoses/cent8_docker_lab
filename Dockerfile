#initially based off Adam Miller's CentOS/SSH
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# centos8 plus things to make a burly yet disposable ansible test image

FROM centos:centos8
MAINTAINER philmoses@gmail.com

RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd sudo; yum clean all
ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh
RUN ./start.sh
RUN rm /run/nologin
RUN echo 'ansible ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
