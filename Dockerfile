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

#SSH鍵作成
RUN /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ""
RUN /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N ""
RUN /usr/bin/ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
RUN /usr/bin/ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
