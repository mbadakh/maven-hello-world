FROM maven as build
WORKDIR root/
COPY . .
RUN mvn -X package --file ./myapp/pom.xml

FROM openjdk
RUN useradd -ms /bin/bash shiranuser
WORKDIR /home/shiranuser
COPY --from=build root/myapp/target/*.jar . 
USER shiranuser
CMD whoami && java -jar *.jar
