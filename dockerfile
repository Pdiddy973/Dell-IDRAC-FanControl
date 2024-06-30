FROM alpine:edge

RUN apk --no-cache add ipmitool apk-cron

COPY crontab /etc/cron.d/fan-control
COPY adaptivefancontrol.sh /opt/adaptivefancontrol.sh
RUN chmod 0777 /etc/cron.d/fan-control && \
    chmod 0777 /opt/*.sh && \
    /usr/bin/crontab /etc/cron.d/fan-control

# These can be overridden at runtime
ENV IDRAC_HOST=192.168.0.240 \
    IDRAC_USER=root \
    IDRAC_PW=calvin \
    CHECK_INTERVAL=30

CMD /opt/adaptivefancontrol.sh && crond