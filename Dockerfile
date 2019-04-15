FROM ubuntu:18.04

LABEL maintainer="Seth Cook <cooker52@gmail.com>"

RUN echo "UTC" > /etc/timezone \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install -y \
        x11vnc xvfb supervisor mono-runtime mono-complete icewm \
    && rm -rf /var/lib/apt/lists/* /tmp/* \
    && mkdir -p /etc/supervisor/conf.d

ADD http://printm3d.com/files/software_pro_alpha/Linux/m3drealize_1.8.2-1_amd64.deb /tmp/
RUN dpkg -i /tmp/m3drealize_1.8.2-1_amd64.deb \
    && rm -rf /tmp/*

COPY supervisord.conf /etc/supervisor/conf.d
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf", "-n"]

EXPOSE 5900
