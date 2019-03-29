###############################################################################
# DOCKERFILE FOR docker-statsd-console
###############################################################################

#
# Description:
#   Simple statsd server that logs metrics to the console
#

FROM node:lts-alpine

# StatsD version
ARG STATSD_VERSION
ARG STATSD_HOME="/opt/statsd-${STATSD_VERSION}"

# Install tini
RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "-g", "--"]

# Download and install statsd
RUN apk add --no-cache --virtual .build-deps                                  \
      binutils-gold                                                           \
      curl                                                                    \
      g++                                                                     \
      gcc                                                                     \
      gnupg                                                                   \
      libgcc                                                                  \
      linux-headers                                                           \
      make                                                                    \
      python                                                                  \
    && curl -LSs --fail -o /tmp/source.tar.gz                                 \
        -- https://github.com/statsd/statsd/archive/v${STATSD_VERSION}.tar.gz \
    && cd /tmp && tar -xzf /tmp/source.tar.gz                                 \
    && rm -f /tmp/source.tar.gz                                               \
    && cd /tmp/statsd-${STATSD_VERSION}                                       \
    && npm install --production                                               \
    && apk del .build-deps                                                    \
    && mv -fv /tmp/statsd-${STATSD_VERSION} ${STATSD_HOME}

# Set Workdir
WORKDIR ${STATSD_HOME}

# Copy config
COPY statsd-config-console.js ./config.js

# Ports
EXPOSE 8125/tcp
EXPOSE 8125/udp
EXPOSE 8126

# Start
CMD [ "node", "stats.js", "config.js" ]

###############################################################################
