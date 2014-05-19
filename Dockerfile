# Docker container for a basic cloud server
#
# Build from lastest stable source code


FROM centos
MAINTAINER Chris Collins <collins.christopher@gmail.com>

EXPOSE 22

CMD ["/bin/bash"]
