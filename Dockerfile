FROM golang:1.19-alpine AS buider
RUN mkdir /build
ADD go.mod go.sum hello.go /build/
WORKDIR /build
RUN go build

FROM alpine
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=buider /build/helloworld /app/
COPY views/ /app/views
WORKDIR /app
CMD ["./helloworld"]