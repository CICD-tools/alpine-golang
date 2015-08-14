NAME:=$(shell basename `git rev-parse --show-toplevel`)
RELEASE:=$(shell git rev-parse --verify --short HEAD)
#USER=myuser
#PASS=mypass
#MAIL=noreply@example.com
#REGISTRY=docker-registry.example.com:8080

all: push

clean:
	docker rmi ${NAME} &>/dev/null || true

build: clean
	docker build --pull=true --no-cache -t ${REGISTRY}/${NAME}:${RELEASE} .
	docker tag -f ${REGISTRY}/${NAME}:${RELEASE} ${REGISTRY}/${NAME}:latest

push: build
#	docker login -u ${USER} -p '${PASS}' -e ${MAIL} ${REGISTRY}
#	docker push ${REGISTRY}/${NAME}:${RELEASE}
#	docker push ${REGISTRY}/${NAME}:latest
