FROM alpine:latest

RUN apk add --no-cache openssh-client rsync && \
    mkdir -p ~/.ssh

COPY *.sh ./

RUN chmod +x *.sh

ENTRYPOINT ["./entrypoint.sh"]