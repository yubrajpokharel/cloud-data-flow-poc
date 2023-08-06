#!/bin/sh

# Start Skipper in the background
java -jar spring-cloud-skipper-server.jar &

# Wait for Skipper to start (you might need to adjust the sleep duration)
sleep 30

# Set the Skipper URL environment variable
export SPRING_CLOUD_DATAFLOW_SKIPPER_URI=http://localhost:7577

# Start Dataflow Server in the background
java -jar spring-cloud-dataflow-server.jar &

# Wait for Dataflow Server to start (you might need to adjust the sleep duration)
sleep 30

echo "Registering the application..."
# Register your Spring Boot application with Spring Dataflow
java -jar spring-cloud-dataflow-shell.jar --dataflow.uri=http://localhost:9393

app register --type task --name my-task --uri docker:/app/sample-app.jar

