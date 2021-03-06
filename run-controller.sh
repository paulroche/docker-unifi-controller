#!/usr/bin/env bash
set +e 
set +x


CONTAINER_NAME="unifi-controller"
IMAGE_NAME="dreamisle.ca/unifi-controller"


docker stop $CONTAINER_NAME || echo "cannot stop a non running $CONTAINER_NAME"
docker rm -f $CONTAINER_NAME || echo "not a container yet: '$CONTAINER_NAME'"

# 8880 8080 8443 37117 

docker run -d \
        -p 6789:6789 \
	-p 8080:8080 \
        -p 8880:8880 \
	-p 8443:8443 \
	-p 27117:27117 \
        -v /mediabox/docker/unifi:/usr/lib/unifi/data \
        --name \
          ${CONTAINER_NAME} ${IMAGE_NAME}
