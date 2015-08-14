NAME:=$(shell basename `git rev-parse --show-toplevel`)
RELEASE:=$(shell git rev-parse --verify --short HEAD)
USER=mickep76

# Using internal registry
#USER=myuser
#PASS=mypass
#MAIL=noreply@example.com
#REGISTRY=docker-registry.example.com:8080

all: push

clean:
	docker rmi ${NAME} &>/dev/null || true

build: clean
	docker build --pull=true --no-cache -t ${USER}/${NAME}:${RELEASE} .
	docker tag -f ${USER}/${NAME}:${RELEASE} ${USER}/${NAME}:latest

# Using internal registry
#	docker build --pull=true --no-cache -t ${REGISTRY}/${NAME}:${RELEASE} .
#	docker tag -f ${REGISTRY}/${NAME}:${RELEASE} ${REGISTRY}/${NAME}:latest

push: build
	docker login
	docker push ${USER}/${NAME}:${RELEASE}
	docker push ${USER}/${NAME}:latest

# Using internal registry
#	docker login -u ${USER} -p '${PASS}' -e ${MAIL} ${REGISTRY}
#	docker push ${REGISTRY}/${NAME}:${RELEASE}
#	docker push ${REGISTRY}/${NAME}:latest
