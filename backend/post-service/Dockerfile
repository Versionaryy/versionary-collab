FROM maven:3.9-eclipse-temurin-24 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:24-jdk-slim


WORKDIR /app


COPY --from=build /app/target/post-service.jar app.jar

EXPOSE 8089

CMD ["java", "-jar", "app.jar"]
