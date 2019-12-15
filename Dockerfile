FROM node:lts-buster

USER root
ARG user=jenkins
ARG group=jenkins
ARG uid=124
ARG gid=129
ARG docker_gid=128

RUN addgroup docker --gid=${docker_gid};

# install make and git 
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && apt-get install -y --no-install-recommends git

# Install the latest Docker CE binaries and add user `jenkins` to the docker group
RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce && \
   groupadd -g ${gid} ${group}  && \
   useradd -M -u ${uid} -g ${gid} ${user} && \
   usermod -aG docker jenkins 

# drop back to the regular jenkins user - good practice
USER jenkins
