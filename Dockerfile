FROM gradle:7.5-jdk18 AS build
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN ./gradlew build --no-daemon

FROM openjdk:18-oracle
EXPOSE 8080
RUN mkdir /app
COPY --from=build /app/build/libs/* /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
