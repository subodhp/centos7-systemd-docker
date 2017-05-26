# A basic Apache Tomcat server to showcase the CI/CD flow using Jenkins/Docker
# Based on http://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container/ to circumvent the SystemD inside Docker known issue

FROM centos
MAINTAINER Subodh Pachghare version: 0.1 <subodh.cyber@gmail.com>
ENV container docker
RUN yum install -y systemd 
RUN yum install -y java-1.8.0-openjdk-headless
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
