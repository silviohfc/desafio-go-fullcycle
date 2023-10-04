FROM golang:latest as builder

WORKDIR /usr/src/app
RUN go mod init example/hello && \
    go mod download && go mod verify
COPY . .
RUN go build -v -o /usr/local/bin/app ./...

FROM scratch
WORKDIR /
COPY --from=builder /usr/local/bin/app .
CMD [ "./app" ]