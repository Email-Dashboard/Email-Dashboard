FROM golang:latest

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

ENV GOBIN /go/bin
ENV GIN_MODE release

RUN mkdir /go-api-worker
RUN mkdir /go/src/Email-Dashboard && mkdir /go/src/Email-Dashboard/go-api-worker

ADD . /go/src/Email-Dashboard/go-api-worker

RUN mkdir /var/db

WORKDIR /go/src/Email-Dashboard/go-api-worker
#RUN go get -u github.com/golang/dep/...

#RUN dep ensure
ENV GO111MODULE=on
ENV GOFLAGS=-mod=vendor

RUN go mod tidy

EXPOSE 80
