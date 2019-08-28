FROM centos:latest

MAINTAINER procyon007

#各環境変数
ENV USER ansible
ENV HOME /home/${USER}
ENV SHELL /bin/bash

#パッケージのアップデート＆インストール
RUN yum -y update && yum clean all
RUN yum install -y which
RUN yum install -y wget
RUN yum install -y tar
RUN yum install -y vim
RUN yum -y install openssh-server openssh-clients

#ansible用のユーザ作成
RUN useradd -m ansible
RUN echo "ansible    ALL=(ALL)       ALL" >> /etc/sudoers
RUN echo "${USER}:password123" | chpasswd

#ログインシェルを指定
#RUN sed -i.bak -e "s#${HOME}:#${HOME}:${SHELL}#" /etc/passwd

EXPOSE 22

CMD \["/usr/sbin/sshd", "-D"\]
