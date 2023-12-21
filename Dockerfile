ARG JDK_IMAGE=docker.io/library/eclipse-temurin:21-jdk-alpine

FROM ${JDK_IMAGE}

ARG SBT_VERSION=1.9.8

RUN apk update \
 && apk add --no-cache curl bash nodejs

# Install sbt
RUN curl -L -o /tmp/sbt.tar.gz "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
 && cd /opt \
 && tar xfv /tmp/sbt.tar.gz \
 && ln -s /opt/sbt/bin/sbt /usr/local/bin

WORKDIR /src

