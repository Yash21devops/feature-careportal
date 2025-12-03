########################
# 1) Build stage
########################
FROM maven:3.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /build

# Copy only pom first (better layer cache)
COPY pom.xml .

# Download dependencies (offline cache)
RUN mvn -q -B dependency:go-offline

# Now copy source code
COPY src ./src

# Build the jar (skip tests here – they will run in CI pipeline)
RUN mvn -q -B package -DskipTests

########################
# 2) Runtime stage
########################
FROM eclipse-temurin:17-jre-alpine AS runtime

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create app directory
WORKDIR /app

# Install curl for container healthcheck
RUN apk add --no-cache curl

# Copy jar from build stage
# 👉 Change the JAR name here if your artifact is different
COPY --from=build /build/target/*.jar /app/app.jar

# Expose app port
EXPOSE 8080

# Environment (optional)
ENV JAVA_OPTS=""

# HEALTHCHECK – hits /health endpoint
# If your endpoint is different (e.g. /actuator/health), change URL
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Run as non-root
USER appuser

# Start the app
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
