## Publishing

```bash
# Set version
declare STATSD_VERSION="0.8.1"

# Build
docker build                                    \
--build-arg STATSD_VERSION=${STATSD_VERSION}    \
--force-rm                                      \
--pull                                          \
--tag mayachit/statsd-console:${STATSD_VERSION} \
.

# Start
docker run              \
--detach                \
--name "statsd-console" \
--publish 8152:8152     \
--rm                    \
mayachit/statsd-console:${STATSD_VERSION}

# Test
echo "foo:1|c" | nc -u -w0 127.0.0.1 8125

# Verify
docker logs statsd-console

# Stop
docker stop statsd-console
docker rm statsd-console

# Push
docker tag mayachit/statsd-console:${STATSD_VERSION} mayachit/statsd-console:latest
docker push mayachit/statsd-console:${STATSD_VERSION}
docker push mayachit/statsd-console:latest
```
