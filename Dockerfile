FROM debian:trixie-slim

ARG FIREBASE_VERSION=14.24.0

VOLUME ["/app"]

COPY run.sh /run.sh

RUN apt update \
&& apt upgrade -y \
&& apt-get -y --fix-missing install --no-install-recommends openjdk-21-jre curl gosu nodejs npm \
&& npm install -g firebase-tools@$FIREBASE_VERSION \
&& apt-get autoremove -y \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/* \
&& npm cache clean --force \
&& chmod +x /run.sh

WORKDIR /app/

ENTRYPOINT ["/run.sh"]
CMD [ "emulators:start", "--import=/app/data",  "--export-on-exit=/app/data" ]