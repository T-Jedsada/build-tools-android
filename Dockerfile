FROM pondthaitay/java-build-android

LABEL MAINTAINER Jedsada Tiwongvorakul <pondthaitay@gmail.com>

ENV ANDROID_HOME /opt/android-sdk-linux
ENV GRADLE_VERSION 4.4

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    ANDROID_BUILD_TOOLS_VERSION=27 \
    ANDROID_APIS="android-26" \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip" \
    ANDROID_HOME="/opt/android-sdk-linux"

# Install Android SDK
RUN cd /opt \
    && wget -q ${ANDROID_SDK_URL} -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager --licenses

# Platform tools
RUN sdkmanager "emulator" "tools" "platform-tools"

RUN yes | sdkmanager \
    "platforms;android-27" \
    "build-tools;27.0.3" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services"

# Cleaning
RUN apt-get clean

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

RUN echo "sdk.dir=$ANDROID_HOME" > local.properties


# RUN cd / opt \
#     && wget $GRADLE_URL -O gradle.zip \
#     && unzip gradle.zip \
#     && mv gradle-${GRADLE_VERSION} gradle \
#     && rm gradle.zip

# # Configure Gradle Environment	
# ENV GRADLE_HOME /opt/gradle
# ENV PATH $PATH:$GRADLE_HOME/bin	
# ENV GRADLE_USER_HOME ~/.gradle

# Install Gradle
WORKDIR /usr/bin
RUN wget wget $GRADLE_URL -O gradle.zip \
    && unzip gradle.zip \
    && mv gradle-${GRADLE_VERSION} gradle \
    && rm gradle.zip

# Configure Gradle Environment
ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin