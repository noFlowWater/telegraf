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

# CONF_FILE에서 .conf 확장자를 제외한 이름을 CONFIGMAP_NAME으로 사용합니다.
CONFIGMAP_NAME="${CONF_FILE%.*}"

# CONFIGMAP_NAME을 사용하여 deploy.yaml 파일의 이름을 설정합니다.
DEPLOY_FILENAME="deploy-${CONFIGMAP_NAME}.yaml"

# generate-deploy-file.sh 스크립트를 source로 가져옵니다.
source generate-deploy-file.sh 

generate_deploy_file $CONFIGMAP_NAME

# 생성된 deploy.yaml 파일을 사용하여 배포된 리소스 삭제
kubectl delete -f $DEPLOY_FILENAME

# 생성된 deploy.yaml 파일 삭제
rm -f $DEPLOY_FILENAME

# configmap 삭제
kubectl delete configmap $CONFIGMAP_NAME -n telegraf

echo ">> Cleanup complete <<"
