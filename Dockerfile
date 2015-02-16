FROM dockerfile/nodejs

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN useradd docker -G sudo -d /home/docker -m
# sudo without password
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Bower an ember stuff
RUN npm install -g bower
RUN npm install -g ember-cli
RUN apt-get install -y phantomjs

# Java
RUN apt-get install -y openjdk-7-jre

VOLUME ["/home/docker/.ssh"]

EXPOSE 22
EXPOSE 9000
CMD ["/usr/sbin/sshd", "-D"]

