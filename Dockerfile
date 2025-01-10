FROM golang:1.22.3-alpine AS builder

RUN apk update && apk add --no-cache curl bash nano

WORKDIR /app/src

COPY go.mod go.sum ./
RUN go mod tidy

ARG VERSION=1.0.0
ARG CGO_ENABLED=0
ENV CGO_ENABLED=${CGO_ENABLED}

COPY . .

RUN go build -ldflags "-s -w -X main.version=${VERSION}" -o /app/authentication main.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /app/authentication ./authentication

EXPOSE 8080

CMD ["./authentication"]