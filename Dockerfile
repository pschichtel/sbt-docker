ARG JDK_IMAGE=docker.io/library/eclipse-temurin:21-jdk-jammy

FROM ${JDK_IMAGE}

ARG SBT_VERSION=1.9.8
ARG NODE_VERSION=20

RUN apt-get update \
 && apt-get install -y gnupg \
 && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
 && apt-get update \
 && apt-get install -y nodejs \
 && apt-get clean

# Install sbt
RUN curl -L -o /tmp/sbt.tar.gz "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
 && cd /opt \
 && tar xfv /tmp/sbt.tar.gz \
 && ln -s /opt/sbt/bin/sbt /usr/local/bin

WORKDIR /src

