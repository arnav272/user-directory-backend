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

# Run the built JAR (uses shell to dynamically find the jar)
CMD sh -c 'java -jar $(find target -name "*.jar" | head -n 1)'