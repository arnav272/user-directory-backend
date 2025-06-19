# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Build app
RUN ./mvnw clean package -DskipTests

# Expose Spring Boot default port
EXPOSE 8080

# Run the Spring Boot fat jar using Boot loader
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]