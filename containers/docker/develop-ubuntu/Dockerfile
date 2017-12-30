FROM ubuntu:xenial

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang git make gcc libc-dev ca-certificates && \
  git clone --depth 1 https://github.com/japariyen/go-japariyen && \
  (cd go-japariyen && make gjpy) && \
  cp go-japariyen/build/bin/gjpy /gjpy && \
  apt-get remove -y golang git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-japariyen

EXPOSE 8945
EXPOSE 11235

ENTRYPOINT ["/gjpy"]
