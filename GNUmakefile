MUSL_VERSION:=10.2.1
ZLIB_VERSION:=1.2.12
DOCKER_TAG:=growse/musl-toolchains:x86_64-linux_${MUSL_VERSION}-zlib_${ZLIB_VERSION}

.PHONY: build
build:
	docker buildx build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$(git rev-parse HEAD) --build-arg MUSL_VERSION=${MUSL_VERSION} --build-arg ZLIB_VERSION=${ZLIB_VERSION} -t ${DOCKER_TAG} .

publish:
	docker push ${DOCKER_TAG}