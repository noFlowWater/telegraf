# Telegraf Deployment in Kubernetes

이 프로젝트는 Kubernetes 환경에서 Telegraf를 배포하기 위한 스크립트와 설정 파일을 포함합니다.

## 전제 조건 및 가정

스크립트를 실행하기 전에 다음 조건들이 충족되어야 합니다:

- 이 스크립트들은 Kubernetes 마스터 노드에서 실행되어야 합니다. 즉, `kubectl` 명령어가 실행될 수 있는 환경이어야 합니다.
- `deploy-telegraf.sh` 및 `cleanup-telegraf.sh` 스크립트는 `.conf` 파일과 같은 디렉토리에 위치해야 합니다. 이 `.conf` 파일은 Telegraf의 설정을 담고 있으며 스크립트 실행 시 첫 번째 인자로 제공되어야 합니다.
- Kubernetes 클러스터에 접근 권한이 있어야 하며, `kubectl` 명령어가 해당 클러스터와 통신할 수 있도록 설정되어 있어야 합니다.
- 이 스크립트는 `telegraf:alpine` Telegraf 공식 도커 이미지를 사용중입니다. [참조링크](https://hub.docker.com/layers/library/telegraf/alpine/images/sha256-d189764c89938a053ffe822ac51dae896fd911a007c91777ec1983a0d568b75c?context=explore)


## 파일 설명

- `deploy-telegraf.sh`: 이 스크립트는 `telegraf`라는 이름의 Kubernetes 네임스페이스를 생성하고, 해당 네임스페이스 안에 Telegraf Pod과 관련 ConfigMap을 배포합니다. 스크립트 실행 시 Telegraf 설정 파일을 인자로 제공해야 합니다.
- `cleanup-telegraf.sh`: 이 스크립트는 `telegraf` 네임스페이스 내에 배포된 Telegraf Pod와 ConfigMap을 제거합니다. 단, `telegraf` 네임스페이스 자체는 제거하지 않습니다.
- `generate-deploy-file.sh`: Telegraf 배포를 위한 YAML 파일을 동적으로 생성하는 스크립트입니다.
- `example.conf`: Telegraf 구성의 예제 파일입니다. 실제 환경에 맞게 수정하여 사용하세요.
- `.gitignore`: Git 추적에서 제외할 파일 패턴을 지정합니다.
- `README.md`: 프로젝트 설명과 사용 방법을 담고 있는 파일입니다.

## 사용 방법

### Telegraf 배포

1. `deploy-telegraf.sh` 스크립트를 사용하여 Telegraf를 배포합니다. 이 스크립트는 첫 번째 인자로 Telegraf 설정 파일을 받습니다.


   ```bash
    ./deploy-telegraf.sh my-config.conf
   ```

### Telegraf 정리

1. `cleanup-telegraf.sh` 스크립트를 사용하여 배포된 Telegraf와 관련 리소스를 정리합니다. 이 스크립트 역시 첫 번째 인자로 Telegraf 설정 파일을 받습니다.

   ```bash
   ./cleanup-telegraf.sh my-config.conf
   ```
    