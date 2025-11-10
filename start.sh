#!/bin/bash
DEPLOYMENT_CONFIG=/opt/configs/deployment.toml

if [ -f "$DEPLOYMENT_CONFIG" ]; then
    cat $DEPLOYMENT_CONFIG > /opt/wso2is-6.2.0/repository/conf/deployment.toml
fi

sh /opt/wso2is-6.2.0/bin/wso2server.sh
