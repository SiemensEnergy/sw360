# Copyright (c) Bosch Software Innovations GmbH 2016.
# Part of the SW360 Portal Project.
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0

# This can be used to compile SW360 via:
# $ docker build -f sw360dev.Dockerfile -t sw360/sw360dev --rm=true --force-rm=true .
# $ docker run -i -v $(pwd):/sw360portal -w /sw360portal --net=host -u $(id -u):$(id -g) sw360/sw360dev mvn package -DskipTests

FROM eclipse-temurin:11.0.22_7-jdk-jammy

ADD scripts/install-thrift.sh /install-thrift.sh
RUN apt-get update -qq && \  
    DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-pip build-essential libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config libssl-dev git maven cmake && \  
    pip install mkdocs mkdocs-material && \  
    chmod +x install-thrift.sh && \  
    bash install-thrift.sh  &&\
    apt-get -y clean &&\
    rm -rf /var/lib/apt/lists/* /var/cache/debconf/*

CMD /bin/bash
