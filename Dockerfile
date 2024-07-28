FROM maven:amazoncorretto as builder

WORKDIR /app

COPY . .

RUN mvn clean install

FROM artisantek/tomcat:1

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps

CMD ["catalina.sh", "run"]
