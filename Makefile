NAME=alpine-golang
RELEASE:=$(shell git rev-parse --verify --short HEAD)
USER=mickep76

all: push

clean:
	docker rmi ${NAME} &>/dev/null || true

build: clean
	docker build --pull=true --no-cache -t ${USER}/${NAME}:${RELEASE} .
	docker tag -f ${USER}/${NAME}:${RELEASE} ${USER}/${NAME}:latest

push: build
	docker login -u ${USER}
	docker push ${USER}/${NAME}:${RELEASE}
	docker push ${USER}/${NAME}:latest
