FROM mcr.microsoft.com/vscode/devcontainers/go AS go

RUN go install github.com/nats-io/natscli/nats@latest
RUN cp "$(which nats)" /

FROM hardliner66/eos:dev

COPY --from=go /nats /usr/local/bin

RUN mkdir /ext
COPY teleplot-eos.vsix /ext/teleplot-eos.vsix
COPY install-private-vsix.sh /ext/install-private-vsix.sh
RUN chmod +x /ext/install-private-vsix.sh && chown -R vscode:vscode /ext
RUN echo '/tmp/eos-operator:0  /explore/system  9p  noauto,user,version=9p2000.L,trans=unix,uname=vscode  0  0' >> /etc/fstab

USER vscode

RUN nats context add default --server msgbus:4222 --description "default" --select
