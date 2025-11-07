FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/Springdemo-0.0.1-SNAPSHOT.war /app/app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.war"]
