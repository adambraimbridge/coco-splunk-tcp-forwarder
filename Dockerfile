FROM gliderlabs/alpine:3.2

ADD . /splunk-http-forwarder
RUN apk --update add go git\
  && export GOPATH=/.gopath \
  && go get github.com/Financial-Times/coco-splunk-http-forwarder \
  && cd splunk-http-forwarder \
  && go build \
  && mv splunk-http-forwarder /coco-splunk-http-forwarder \
  && apk del go git \
  && rm -rf $GOPATH /var/cache/apk/*

CMD /coco-splunk-http-forwarder -url=$FORWARD_URL