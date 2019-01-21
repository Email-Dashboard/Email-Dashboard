FROM golang:latest

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

ENV GOBIN /go/bin
ENV GIN_MODE release

RUN mkdir /go-api-worker
RUN mkdir /go/src/Email-Dashboard && mkdir /go/src/Email-Dashboard/go-api-worker
RUN mkdir /var/db

WORKDIR /go/src/Email-Dashboard/go-api-worker
copy . .

#RUN go get -u github.com/golang/dep/...

#RUN dep ensure
ENV GO111MODULE=on
ENV GOFLAGS=-mod=vendor

RUN http_proxy="http://10.8.15.225:8443" https_proxy="http://10.8.15.225:8443" go mod tidy

RUN go build -o /go-api-worker/main .

CMD ["/go-api-worker/main"]

EXPOSE 80
