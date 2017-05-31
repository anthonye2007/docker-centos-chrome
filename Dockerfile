FROM centos:7

MAINTAINER Mads Konradsen (madskonradsen)

ADD ./google-x86_64.repo /etc/yum.repos.d/external.repo
RUN yum install -y google-chrome-stable

RUN useradd headless --shell /bin/bash --create-home \
  && usermod -a -G sudo headless \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'headless:nopassword' | chpasswd

RUN mkdir /data

ENTRYPOINT ["/usr/bin/google-chrome-unstable", \
            "--disable-gpu", \
            "--headless", \
            "--remote-debugging-address=0.0.0.0", \
            "--remote-debugging-port=9222", \
            "--user-data-dir=/data"]