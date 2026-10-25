# syntax=docker/dockerfile:1

FROM node:22-bookworm@sha256:63538dfe497cc29dfafdda25ada09b46db68a3f4cc205abf1f5d6bf0913f3384 AS build

ARG GAGGIMATE_REF=v1.9.0
ARG PLATFORMIO_VERSION=6.2.0

RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential libsdl2-dev python3-venv \
 && rm -rf /var/lib/apt/lists/* \
 && python3 -m venv /opt/pio \
 && /opt/pio/bin/pip install --no-cache-dir "platformio==${PLATFORMIO_VERSION}"

ENV PATH="/opt/pio/bin:${PATH}"

RUN git clone --depth 1 --branch "${GAGGIMATE_REF}" https://github.com/jniebuhr/gaggimate /src
WORKDIR /src
# Upstream relies on a transitive <stdexcept> include that GCC 12 does not provide.
ENV PLATFORMIO_BUILD_FLAGS="-include stdexcept"
# display-sim does not run the version script of the firmware envs, so write src/version.h here.
RUN printf '#pragma once\n#define BUILD_GIT_VERSION "%s"\n#define BUILD_TIMESTAMP "%s"\n' "${GAGGIMATE_REF}" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > src/version.h \
 && scripts/build_webui.sh && pio run -e display-sim


FROM debian:bookworm-slim@sha256:7ff6ba31527b9e336162fa061746c366c4b2032f4d2cff2078bea43f78efe3f8

ARG GAGGIMATE_REF=v1.9.0

LABEL org.opencontainers.image.title="gaggimate-sim" \
      org.opencontainers.image.description="Desktop simulator of the GaggiMate display firmware (display-sim), with its web UI on port 8080" \
      org.opencontainers.image.source="https://github.com/mxkissnr/gaggimate-sim" \
      org.opencontainers.image.licenses="CC-BY-NC-SA-4.0" \
      gaggimate.source="https://github.com/jniebuhr/gaggimate" \
      gaggimate.ref="${GAGGIMATE_REF}"

RUN apt-get update \
 && apt-get install -y --no-install-recommends libsdl2-2.0-0 xvfb xauth \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /src/.pio/build/display-sim/program /app/gaggimate-sim

# The simulator persists state in ./sim_data relative to its working directory.
RUN mkdir /sim_data \
 && ln -s /sim_data /app/sim_data \
 && printf '#!/bin/sh\nXvfb :99 -screen 0 1024x768x24 &\nsleep 1\nexport DISPLAY=:99\nexec /app/gaggimate-sim\n' > /app/start.sh \
 && chmod +x /app/start.sh

WORKDIR /app
VOLUME /sim_data
EXPOSE 8080
CMD ["/app/start.sh"]
