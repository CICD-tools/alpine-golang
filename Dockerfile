FROM gliderlabs/alpine

RUN apk-install git make

RUN apk --update-cache --allow-untrusted \
        --repository http://dl-4.alpinelinux.org/alpine/edge/community \
        --arch=x86_64 add \
    go \
    && rm -rf /var/cache/apk/*

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GO15VENDOREXPERIMENT 1

RUN mkdir -p ${GOPATH}/{src,bin}

WORKDIR $GOPATH

CMD ["make"]
