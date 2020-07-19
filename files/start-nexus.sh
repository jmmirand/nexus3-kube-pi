#!/bin/bash
echo "Nexus Version : ${NEXUS3_VERSION}"
cd ${NEXUS3_HOME}/${NEXUS3_VERSION}
exec ./bin/nexus run
