FROM openjdk:21

WORKDIR /app

ARG APP_VERSION=0.0.1-SNAPSHOT

COPY build/libs/f1-${APP_VERSION}.jar app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]