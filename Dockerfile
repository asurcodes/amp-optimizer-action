FROM golang:latest

RUN go get -u github.com/ampproject/amppackager/cmd/transform

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]