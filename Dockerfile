FROM registry.access.redhat.com/ubi8/ubi

LABEL name="Nexus Repository Manager for RaspBery PI 4 Modelo B" \
      maintainer="Jose Miguel Miranda <jmmirand@gmail.com>" \
      version="3.25.0-03" \
      release="3.25.0" \
      run="docker run -d --name NAME \
          -p 8081:8081 \
          IMAGE" \
      stop="docker stop NAME"

# url dowload nexus3 files
# https://help.sonatype.com/repomanager3/download/download-archives---repository-manager-3

ENV NEXUS3_VERSION=nexus-3.25.0-03
ENV NEXUS_DOWNLOAD_URL=https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz
ENV NEXUS_DOWNLOAD_SHA256_HASH=4034ceaca2633124fd49ecfec8dd73367bd94a308595fd864ab461a86284a9f8

ENV SONATYPE_DIR=/opt
ENV NEXUS3_HOME=${SONATYPE_DIR}/nexus \
    NEXUS3_DATA=/nexus-data \
    NEXUS3_CONTEXT='' \
    SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work \
    DOCKER_TYPE='rh-docker'

COPY ./files/start-nexus.sh ${NEXUS3_HOME}/${NEXUS3_VERSION}/start-nexus.sh
RUN chmod +x ${NEXUS3_HOME}/${NEXUS3_VERSION}/start-nexus.sh

RUN yum install java wget -y; \
    java -version; \
    mkdir -p ${NEXUS3_HOME}/donwload; \
    curl -L -o ${NEXUS3_HOME}/donwload/${NEXUS3_VERSION}-unix.tar.gz  https://download.sonatype.com/nexus/3/${NEXUS3_VERSION}-unix.tar.gz; \
    gunzip  ${NEXUS3_HOME}/donwload/${NEXUS3_VERSION}-unix.tar.gz; \
    tar xvf ${NEXUS3_HOME}/donwload/${NEXUS3_VERSION}-unix.tar --directory  ${NEXUS3_HOME}; \
    rm -rf ${NEXUS3_HOME}/donwload

# Actualizamos las opciones.
COPY ./files/nexus.vmoptions ${NEXUS3_HOME}/${NEXUS3_VERSION}/bin/nexus.vmoptions
COPY ./files/nexus-default.properties ${NEXUS3_HOME}/${NEXUS3_VERSION}/etc/nexus-default.properties



EXPOSE 8081
CMD ${NEXUS3_HOME}/${NEXUS3_VERSION}/start-nexus.sh
