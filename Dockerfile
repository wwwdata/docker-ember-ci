FROM node

# add backports
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN useradd docker -G sudo -d /home/docker -m
# sudo without password
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Java
RUN apt-get -t jessie-backports -y install openjdk-8-jre-headless

VOLUME ["/home/docker/.ssh"]
VOLUME ["/data"]

EXPOSE 22
EXPOSE 9000
CMD ["/usr/sbin/sshd", "-D"]

