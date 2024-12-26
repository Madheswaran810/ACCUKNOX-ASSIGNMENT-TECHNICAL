# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the executable JAR file
COPY target/wisecow-0.0.1-SNAPSHOT.jar /app/wisecow.jar

# Expose the port the app runs on
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "wisecow.jar"]
