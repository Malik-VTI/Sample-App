# Build stage
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build aplikasi
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:17-slim
WORKDIR /app

# Copy JAR dari build stage
COPY --from=build /app/target/*.jar app.jar

# Environment variables
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://10.100.33.85:5432/sampleapp
ENV SPRING_DATASOURCE_USERNAME=postgres
ENV SPRING_DATASOURCE_PASSWORD=M@B#26L2KUns

EXPOSE 1011
ENTRYPOINT ["java","-jar","app.jar"]