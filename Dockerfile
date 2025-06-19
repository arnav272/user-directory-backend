# Use OpenJDK as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Build application
RUN ./mvnw package -DskipTests

# Run application
CMD ["java", "-jar", "$(find target -name '*.jar' | head -n 1)"]