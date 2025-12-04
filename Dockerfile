########################
# 1) Build stage
########################
FROM maven:3.9-eclipse-temurin-17 AS build

# Work inside /build
WORKDIR /build

# Copy pom.xml from the careportal-service module
COPY careportal-service/pom.xml ./pom.xml

# Download dependencies (for caching)
RUN mvn -q -B dependency:go-offline

# Copy source code from the careportal-service module
COPY careportal-service/src ./src

# Build the jar (tests are already run in CI)
RUN mvn -q -B package -DskipTests

########################
# 2) Runtime stage
########################
FROM eclipse-temurin:17-jre-alpine AS runtime

# Non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# For healthcheck
RUN apk add --no-cache curl

# Copy built JAR from the build stage
COPY --from=build /build/target/*.jar /app/app.jar

EXPOSE 8080

ENV JAVA_OPTS=""

# Healthcheck on /health
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

USER appuser

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
