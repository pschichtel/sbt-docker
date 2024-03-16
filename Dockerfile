ARG JDK_IMAGE=docker.io/library/eclipse-temurin:21-jdk-jammy

FROM docker.io/library/ubuntu:jammy AS libsass

RUN apt update \
 && apt install -y build-essential git libtool

WORKDIR /build

RUN git clone -b "3.6.6"  https://github.com/sass/libsass .
RUN autoreconf --force --install
RUN ./configure --disable-tests --disable-static --prefix=/usr/local
RUN make
RUN make install

FROM ${JDK_IMAGE}

ARG SBT_VERSION=1.9.9
ARG NODE_VERSION=21

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

COPY --from=libsass /usr/local/lib /usr/local/lib

WORKDIR /src

