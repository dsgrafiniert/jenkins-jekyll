FROM jenkins/jenkins
MAINTAINER Dominik Schön <dominik@familie-schoen.com>

# Switch to root
USER root

# Update everything
RUN apt-get -y update 
RUN apt-get -y upgrade

# Install pre-reqs for Jekyll
RUN apt-get -y install zip maven build-essential ruby libffi-dev python python-dev python-pip apt-transport-https ca-certificates curl software-properties-common
RUN apt-get --no-install-recommends -y install fakeroot
RUN apt-get --no-install-recommends -y install sudo && \
	echo "jenkins ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN pip install virtualenv

# ENV VERSION=v4.9.1 NPM_VERSION=2
# ENV VERSION=v6.14.2 NPM_VERSION=3
 ENV VERSION=v8.11.1 NPM_VERSION=5 YARN_VERSION=latest
# ENV VERSION=v10.0.0 NPM_VERSION=6 YARN_VERSION=latest

# For base builds
# ENV CONFIG_FLAGS="--fully-static --without-npm" DEL_PKGS="libstdc++" RM_DIRS=/usr/include


RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -L https://raw.githubusercontent.com/jgsqware/clairctl/master/install.sh | sh
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


RUN apt-get update && apt-get -y install yarn


# Clean up

RUN rm -rf /usr/lib/ruby/gems/*/cache/*.gem

# Switch back to jenkins
USER jenkins

ENV DOCKER_GID_ON_HOST ""
COPY jenkins.sh /usr/local/bin/jenkins.sh
