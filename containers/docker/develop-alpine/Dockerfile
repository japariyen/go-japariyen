FROM alpine:3.5

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/japariyen/go-japariyen && \
  (cd go-ethereum && make gjpy) && \
  cp go-ethereum/build/bin/gjpy /gjpy && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-ethereum && rm -rf /var/cache/apk/*

EXPOSE 8945
EXPOSE 11235

ENTRYPOINT ["/gjpy"]
