FROM golang:latest

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

ENV GOBIN /go/bin
ENV GIN_MODE release
ENV GO111MODULE=on

RUN mkdir /go-api-worker
RUN mkdir /go/src/go-api-worker

ADD . /go/src/go-api-worker

RUN mkdir /var/db

WORKDIR /go/src/go-api-worker

#RUN go get -u github.com/golang/dep/...
#RUN dep ensure

RUN  go mod tidy

#WORKDIR /go/src/go-api-worker/graphql

RUN go build -o /go-api-worker/main .

CMD ["/go-api-worker/main"]

EXPOSE 80
