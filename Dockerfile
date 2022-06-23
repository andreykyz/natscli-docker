FROM golang:1.17-bullseye AS builder

RUN git clone https://github.com/nats-io/natscli.git /natscli
WORKDIR "/natscli"
RUN go mod vendor
RUN go build ./nats/main.go 

# Container strip
FROM buildpack-deps:bullseye as production
COPY --from=builder /natscli/main /bin/natscli
ENTRYPOINT ["/bin/bash"]
