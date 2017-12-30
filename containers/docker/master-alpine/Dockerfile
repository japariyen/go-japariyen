FROM alpine:3.5

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.7 https://github.com/japariyen/go-japariyen && \
  (cd go-japariyen && make gjpy) && \
  cp go-japariyen/build/bin/gjpy /gjpy && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-japariyen && rm -rf /var/cache/apk/*

EXPOSE 8945
EXPOSE 11235

ENTRYPOINT ["/gjpy"]
