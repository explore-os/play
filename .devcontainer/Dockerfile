FROM mcr.microsoft.com/vscode/devcontainers/go AS go

RUN go install github.com/nats-io/natscli/nats@latest
RUN cp "$(which nats)" /

FROM hardliner66/eos:latest

COPY --from=go /nats /usr/local/bin

RUN mkdir -p /explore/storage && chown -R vscode:vscode /explore/storage

RUN mkdir /ext
COPY teleplot-eos.vsix /ext/teleplot-eos.vsix
COPY install-private-vsix.sh /ext/install-private-vsix.sh
RUN chmod +x /ext/install-private-vsix.sh && chown -R vscode:vscode /ext

USER vscode

RUN nats context add default --server msgbus:4222 --description "default" --select