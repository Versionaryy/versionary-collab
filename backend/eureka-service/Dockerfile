# --- Stage 1: Build the application using Maven ---
FROM maven:3.9-eclipse-temurin-24 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# --- Stage 2: Create the final, lightweight production image ---
FROM openjdk:24-jdk-slim
WORKDIR /app
# Copy only the built JAR from the 'build' stage
COPY --from=build /app/target/eureka-service-*.jar app.jar
EXPOSE 8761
CMD ["java", "-Xmx200m", "-jar", "app.jar"]
