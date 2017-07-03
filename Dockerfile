FROM hypriot/rpi-alpine:latest

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN buildDeps="gcc g++ git mercurial make automake autoconf python-dev openssl-dev libffi-dev musl-dev" \
  && apk --update add $buildDeps \
  && apk add \
    python \
    py2-pip py2-openssl \
    ffmpeg-libs \
    ffmpeg \
    unrar \
    openssl \
    ca-certificates \
    p7zip \
    ca-certificates \
    py2-pip ca-certificates git python py-libxml2 py-lxml \
    make gcc g++ python-dev openssl-dev libffi-dev unrar tzdata \
    && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade pyopenssl cheetah requirements

# Set uid/gid (override with the '-e' flag), 1000/1000 used since it's the
# default first uid/gid on a fresh Fedora install
ENV LUID=1000 LGID=1000

# Create the nzbhydra user/group
RUN mkdir -p /opt/nzbhydra/app
RUN addgroup nzbhydra
RUN adduser -s /bin/bash -h /opt/nzbhydra -G nzbhydra -u $LUID nzbhydra -D

# Grab the installer, do the thing
RUN git clone --depth 1 https://github.com/theotherp/nzbhydra.git /opt/nzbhydra/app

# Need a config and storage volume, expose proper port
VOLUME /config
EXPOSE 5075

# Add script to copy default config if one isn't there and start nzbhydra
COPY run-nzbhydra.sh /bin/run-nzbhydra.sh
 
# Run our script
CMD ["/bin/run-nzbhydra.sh"]
