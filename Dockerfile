# Docker container for a basic cloud server
#
# Build from lastest stable source code


FROM centos:centos6
MAINTAINER Chris Collins <collins.christopher@gmail.com>

# Todo: setting up auto pem stuff
# Generate a PEM key like so: ssh-keygen -t rsa -f cloudbase.pem -N '' -m PEM

ADD startup.sh /startup.sh

ADD pre-install.sh /pre-install.sh
RUN /pre-install.sh

EXPOSE 22

CMD ["/bin/bash", "-x", "/startup.sh"]
