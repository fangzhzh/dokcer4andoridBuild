FROM jetbrains/teamcity-agent
USER root
RUN sudo echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

ENV ANDROID_HOME /opt/android-sdk-linux

# Install the unzip tool then download Android SDK into $ANDROID_HOME and unzip it.
# You can find the URL to the current Android SDK version at: https://developer.android.com/studio/index.html

# RUN sudo dpkg --purge --force-depends ca-certificates-java
RUN apt-get -y upgrade && apt-get -y update &&  \
        apt-get install -y openjdk-8-jdk ; exit 0
# RUN  apt-get install -y ca-certificates-java  &&
# RUN   dpkg --purge --force-depends ca-certificates-java && \
#       apt-get install -y ca-certificates-java  && \
#       apt-get install -y maven
RUN     apt-get install -y maven

RUN apt-get update && apt-get install -y \
    unzip && \
    mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip && \
    apt-get remove -y unzip

RUN apt-get install -y --no-install-recommends \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        android-tools-adb \
        redis-tools


ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
# Accept Android SDK licenses
RUN yes | sdkmanager --licenses
RUN yes | sdkmanager "platforms;android-28"
RUN yes | sdkmanager "build-tools;28.0.3"
RUN sdkmanager --install "ndk;20.0.5594570"
RUN sdkmanager --install "ndk;21.0.6113669"
WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
