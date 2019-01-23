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

RUN go mod tidy

#RUN cd graphql
RUN go build -o /go-api-worker/main .

CMD ["/go-api-worker/main"]

EXPOSE 80
