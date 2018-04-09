FROM alpine:3.7
RUN apk update && apk upgrade && apk add bind
EXPOSE 53 53/udp
COPY bind /etc/bind
CMD ["named", "-4gu", "named"]
