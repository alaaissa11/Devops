FROM maven as build
WORKDIR /devopsala
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /devopsala
COPY --from=build /devopsala/target/DevOps_Project-0.0.1-SNAPSHOT.jar /devopsala/
EXPOSE 8082
CMD ["java","-jar","DevOps_Project-0.0.1-SNAPSHOT.jar"]