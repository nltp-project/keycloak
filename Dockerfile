FROM quay.io/keycloak/keycloak:20.0.1

ARG THEME
ARG REALM=main

ENV KEYCLOAK_HOME=/opt/keycloak
ENV KC_DB=mysql
ENV KC_HTTP_RELATIVE_PATH=/auth
ENV KC_HEALTH_ENABLED=true

WORKDIR ${KEYCLOAK_HOME}

COPY ./themes/${THEME}-theme themes/${THEME}-theme
COPY ./realms/${REALM}-realm.json data/import/${REALM}-realm.json

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 9999 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

RUN ${KEYCLOAK_HOME}/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start --import-realm"]
