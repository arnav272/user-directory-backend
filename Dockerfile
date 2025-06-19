# Use OpenJDK 17 as base
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml separately (cache dependencies)
COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy full source code
COPY src ./src

# Build JAR
RUN ./mvnw package -DskipTests

# Expose port
EXPOSE 8080

# Run JAR
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]