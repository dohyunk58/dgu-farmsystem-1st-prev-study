# 베이스 이미지 선택 (Java 17 환경)
FROM amazoncorretto:17-alpine-jdk AS builder
WORKDIR /app
COPY gradlew .
COPY gradlew.bat .
RUN chmod +x gradlew
COPY gradle ./gradle
COPY build.gradle .
COPY settings.gradle .
RUN ./gradlew dependencies --no-daemon # 의존성 다운로드 (캐싱 활용)

COPY src ./src
RUN ./gradlew bootJar --no-daemon # Spring Boot Jar 파일 생성 (일반 Java 프로젝트는 jar 태스크)

# 최종 이미지 생성 (JRE만 포함하여 이미지 크기 최적화)
FROM amazoncorretto:17-alpine-jre
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]