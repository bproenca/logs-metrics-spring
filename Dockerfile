FROM adoptopenjdk:11-jdk-hotspot
COPY target/*.jar app.jar
EXPOSE 8080
CMD java -jar /app.jar