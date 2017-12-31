# Build Gjpy in a stock Go builder container
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-japariyen
RUN cd /go-japariyen && make gjpy

# Pull Gjpy into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-japariyen/build/bin/gjpy /usr/local/bin/

EXPOSE 8945 8946 11235 11235/udp 11236/udp
ENTRYPOINT ["gjpy"]
