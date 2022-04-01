FROM alpine:3.15.3

RUN apk add curl jq git

COPY clone-gitlab.sh /script/clone-gitlab.sh

WORKDIR /script

ENTRYPOINT ["./clone-gitlab.sh"]
