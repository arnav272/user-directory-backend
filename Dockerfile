# Use OpenJDK as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Build the application
RUN ./mvnw clean package -DskipTests

# Expose the port your app runs on
EXPOSE 8080

# Run the built JAR (assuming your app creates one jar in /target)
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]