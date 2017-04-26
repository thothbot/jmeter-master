FROM thothbot/alpine-jre8
MAINTAINER Alex Usachev <thothbot@gmail.com>

ENV JMETER_VERSION=3.2 \
    JMETER_PLUGINS_VERSION=1.4.0 \
    JMETER_HOME=/opt/jmeter \
    PATH=${PATH}:/opt/jmeter/bin

RUN set -ex && \
     apk upgrade --update && \
     apk add --update libstdc++ curl ca-certificates unzip bash && \

     curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jm.tar.gz \
        https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
     curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jm-plugins.zip \
        https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-${JMETER_PLUGINS_VERSION}.zip && \

     tar -C /opt -zxf /tmp/jm.tar.gz && \
     unzip -o /tmp/jm-plugins.zip -d /opt/apache-jmeter-${JMETER_VERSION}/ && \

     ln -s /opt/apache-jmeter-${JMETER_VERSION} /opt/jmeter && \

     apk del curl unzip && \
     rm -fr /tmp/*

# Ports to be exposed from the container for JMeter Master
EXPOSE 60000
