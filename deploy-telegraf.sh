#!/bin/bash

# 첫 번째 인자로부터 CONF_FILE을 받습니다.
CONF_FILE=$1

# 사용법 안내와 스크립트 종료
usage() {
    echo "Usage: $0 CONF_FILE"
    echo "Example: $0 my-config.conf"
    exit 1
}

# CONF_FILE이 제공되지 않았다면 사용법을 출력합니다.
if [ -z "$CONF_FILE" ]; then
    usage
fi

CONFIGMAP_NAME="${CONF_FILE%.*}"

kubectl create ns telegraf

# CONFIGMAP_NAME을 사용하여 configmap을 생성합니다.
kubectl create configmap $CONFIGMAP_NAME --from-file=telegraf.conf=$CONF_FILE -n telegraf

# generate-deploy-file.sh 스크립트를 source로 가져옵니다.
source generate-deploy-file.sh 

generate_deploy_file $CONFIGMAP_NAME

kubectl apply -f $DEPLOY_FILENAME

echo ">> Deploy $CONF_FILE complete <<"

# 생성된 deploy.yaml 파일 삭제
rm -f $DEPLOY_FILENAME