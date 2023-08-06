# Use a base image with Java and necessary tools
FROM openjdk:17-alpine

# Set environment variables
ENV SPRING_DATFLOW_VERSION=2.10.2
ENV SKIPPER_VERSION=2.9.2
ENV SPRING_APP_VERSION=0.0.1-SNAPSHOT

# Create directories
RUN mkdir /app
WORKDIR /app

# Copy Spring Dataflow Server and Skipper JAR files
COPY spring-cloud-dataflow-server-${SPRING_DATFLOW_VERSION}.jar /app/spring-cloud-dataflow-server.jar
COPY spring-cloud-skipper-server-${SKIPPER_VERSION}.jar /app/spring-cloud-skipper-server.jar

# Copy Spring Cloud Data Flow shell
COPY spring-cloud-dataflow-shell-${SPRING_DATFLOW_VERSION}.jar /app/spring-cloud-dataflow-shell.jar

# Copy your Spring Boot application JAR file
COPY sample-app-${SPRING_APP_VERSION}.jar /app/sample-app.jar

# Expose ports
EXPOSE 9393 7577

# Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Run the entrypoint script
ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh & tail -f /dev/null"]

