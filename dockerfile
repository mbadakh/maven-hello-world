FROM maven as build
WORKDIR root/
COPY . .
RUN mvn package --file ./myapp/pom.xml

FROM openjdk
RUN useradd -ms /bin/bash mk1993
WORKDIR /home/mk1993
COPY --from=build root/myapp/target/*.jar . 
USER mk1993
CMD whoami && java -jar *.jar
