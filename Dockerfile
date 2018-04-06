FROM ubuntu:latest

LABEL maintainer "Jedsata Tiwonvorakul <pondthaitay@gmail.com>" 

# Install java8
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 \
    lib32gcc1 lib32ncurses5 lib32z1 python curl unzip

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.zip \
    --quiet https://dl.google.com/android/repository/tools_r25.2.5-linux.zip && \
    unzip android-sdk.zip && rm -f android-sdk.zip && \
    chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter \
    platform-tools,android-27,build-tools-27,extra-android-m2repository,extra-google-m2repository"]

# Cleaning
RUN apt-get clean

# Create workspace
RUN mkdir -p /pondthaitay/

WORKDIR /pondthaitay/