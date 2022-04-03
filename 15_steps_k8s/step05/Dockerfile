FROM alpine:latest

RUN apk update && \
    apk add bash
ADD ./deamon.sh /deamon.sh

CMD ["/bin/bash", "/deamon.sh"]