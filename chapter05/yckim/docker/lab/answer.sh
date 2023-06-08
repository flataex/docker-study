#!/bin/bash

# 한번의 명령으로 모든 태그 푸시
docker image push -a registry.local:5001/gallery/ui

# 대상 레포지터리의 태그 목록 확인
IMAGE_INFO=$(curl http://registry.local:5001/v2/gallery/ui/tags/list)
TAGS=$(echo "$IMAGE_INFO" | jq -r '.tags[]')

# 이미지 매니페스트 확인
for tag in $TAGS
do
  DIGEST=$(curl -I -H "Accept: application/vnd.docker.distribution.manifest.v2+json" http://registry.local:5001/v2/gallery/ui/manifests/v1 | grep 'Docker-Content-Digest:' | cut -d' ' -f2 | tr -d '[:space:]')
  # API를 통해 이미지 삭제
  curl -X DELETE "http://registry.local:5001/v2/gallery/ui/manifests/$DIGEST"
done

# 이미지가 삭제되었는지 확인
TAGS=$(curl http://registry.local:5001/v2/gallery/ui/tags/list | jq '.tags')

if [ "$TAGS" == 'null' ]; then
  echo "✅ ✅ ✅ 삭제 성공 ✅ ✅ ✅ "
else
  echo "💀 💀 💀삭제 실패 💀 💀 💀 "
fi
