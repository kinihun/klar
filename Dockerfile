FROM golang:1.8-alpine as builder

RUN apk --update add git;
RUN go get -d github.com/optiopay/klar
RUN go build ./src/github.com/optiopay/klar

FROM alpine:3.6

RUN apk -Uuv add --no-cache ca-certificates && \
    apk add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm -rf /var/cache/apk/*
COPY --from=builder /go/klar /klar
