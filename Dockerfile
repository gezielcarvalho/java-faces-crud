# Multi-stage build for Java Faces CRUD application

# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

# Copy pom.xml and download dependencies (layer caching optimization)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Runtime image with Tomcat
FROM tomcat:9.0-jdk21-temurin-jammy

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from builder stage
COPY --from=builder /app/target/java-faces-crud-1.1-SNAPSHOT.war /usr/local/tomcat/webapps/java-faces-crud.war

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port 8080
EXPOSE 8080

# Set environment variables for database connection
ENV DB_HOST=mysql \
    DB_PORT=3306 \
    DB_NAME=helpdesk \
    DB_USER=root \
    DB_PASSWORD=A_1234567

# Use entrypoint script to configure database and start Tomcat
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
