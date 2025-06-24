FROM alpine:3 AS builder
WORKDIR /build
RUN apk add go
RUN go install github.com/dnstap/golang-dnstap/dnstap@latest
RUN find / -type f -iname dnstap


FROM alpine:3 AS run

LABEL maintainer=edgd1er@hotmail.com

COPY --chmod=0555 --from=builder /root/go/bin/dnstap /bin/dnstap
COPY --chmod=0555 docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN apk add doas tzdata tini bash; \
    adduser auser -G wheel; \
    echo 'auser:123' | chpasswd; \
    echo 'permit :wheel as root' > /etc/doas.d/doas.conf ; \
    mkdir /var/log/dnstap ;\
    chown auser:users /bin/dnstap /var/log/dnstap
USER auser

ENV TZ="Europe/Paris" \
    TAPADDRESS="0.0.0.0" \
    TAPPORT="6000" \
    TAPFILE="/dev/stdout"
    TAPFORMAT="q"

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/docker-entrypoint.sh"]
#CMD ["/bin/dnstap","-l","0.0.0.0:6000","-q","-w","/dev/stdout"]

VOLUME /var/log/