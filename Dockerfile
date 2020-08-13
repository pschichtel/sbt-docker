ARG JDK_IMAGE=adoptopenjdk/openjdk14:alpine

FROM ${JDK_IMAGE}

ARG SBT_VERSION=1.3.13

RUN apk update \
 && apk add --no-cache curl bash

# Install sbt
RUN curl -L -o /tmp/sbt.tar.gz "https://piccolo.link/sbt-${SBT_VERSION}.tgz" \
 && cd /opt \
 && tar xfv /tmp/sbt.tar.gz \
 && ln -s /opt/sbt/bin/sbt /usr/local/bin

WORKDIR /src

