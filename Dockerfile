# Base Image:
FROM ubuntu:20.04
#Label
LABEL maintainer logdevops@gmail.com
#Update the base server
RUN apt-get update
# Installing Java 17:
ENV JAVA_HOME /opt/java/openjdk
RUN mkdir -p "$JAVA_HOME"
ENV PATH $JAVA_HOME/bin:$PATH
ENV JAVA_VERSION jdk-17.0.10
COPY jdk-17.0.10_linux-x64_bin.tar.gz /tmp/jdk-17.0.10_linux-x64_bin.tar.gz
RUN tar --extract \
              --file /tmp/jdk-17.0.10_linux-x64_bin.tar.gz \
              --directory "$JAVA_HOME" \
              --strip-components 1 \
              --no-same-owner
RUN rm -rf /tmp/jdk-17.0.10_linux-x64_bin.tar.gz

# Create Group & User:
RUN adduser logdevops
USER logdevops
WORKDIR /home/logdevops

# Installing Application:
COPY /target/demo-1.0.0-SNAPSHOT.jar /home/logdevops/demo-1.0.0-SNAPSHOT.jar

# Port:
EXPOSE 9020
