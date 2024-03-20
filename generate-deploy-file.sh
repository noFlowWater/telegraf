#!/bin/bash

generate_deploy_file() {
    CONFIGMAP_NAME=$1
    DEPLOY_FILENAME="deploy-${CONFIGMAP_NAME}.yaml"

    cat <<EOF >$DEPLOY_FILENAME
apiVersion: v1
kind: Pod
metadata:
  name: $CONFIGMAP_NAME-pod
  namespace: telegraf
spec:
  containers:
  - name: $CONFIGMAP_NAME-container
    image: telegraf:alpine
    volumeMounts:
    - name: $CONFIGMAP_NAME-volume
      mountPath: /etc/telegraf/
  volumes:
  - name: $CONFIGMAP_NAME-volume
    configMap:
      name: $CONFIGMAP_NAME
EOF
}

export -f generate_deploy_file
