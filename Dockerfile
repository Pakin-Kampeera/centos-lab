FROM centos

RUN yum update -y

RUN yum install -y vim && \
    yum install -y passwd && \
    yum install -y sudo