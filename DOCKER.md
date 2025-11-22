# Docker Deployment Guide

This guide explains how to run the Java Faces CRUD application using Docker and Docker Compose.

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+

## Quick Start

### 1. Build and Run with Docker Compose

The easiest way to run the entire application stack:

```bash
docker compose up -d
```

This command will:

- Start a MySQL 8.0 database container
- Run Flyway migrations to set up the database schema
- Build and start the Java application container

### 2. Access the Application

Once all containers are running:

- **Application**: http://localhost:8080/java-faces-crud/
- **Tickets Page**: http://localhost:8080/java-faces-crud/tickets.jsp
- **MySQL**: localhost:3306

### 3. Stop the Application

```bash
docker compose down
```

To remove volumes (database data) as well:

```bash
docker compose down -v
```

## Container Architecture

### Services

1. **mysql** - MySQL 8.0 database

   - Port: 3306
   - Volume: `mysql_data` (persistent storage)
   - Health check: Ensures database is ready before migrations

2. **flyway** - Database migration tool

   - Runs once to apply schema migrations
   - Depends on MySQL being healthy

3. **app** - Java Faces CRUD application
   - Port: 8080
   - Built from Dockerfile
   - Depends on Flyway completing successfully

### Network

All services communicate via a custom bridge network: `helpdesk-network`

## Docker Commands

### Building the Application

Build only the application image:

```bash
docker build -t java-faces-crud:latest .
```

### Running Individual Containers

#### MySQL Only

```bash
docker run -d \
  --name helpdesk-mysql \
  -e MYSQL_ROOT_PASSWORD=A_1234567 \
  -e MYSQL_DATABASE=helpdesk \
  -p 3306:3306 \
  mysql:8.0
```

#### Application Only (requires MySQL running)

```bash
docker run -d \
  --name helpdesk-app \
  -e DB_HOST=mysql \
  -e DB_PORT=3306 \
  -e DB_NAME=helpdesk \
  -e DB_USER=root \
  -e DB_PASSWORD=A_1234567 \
  -p 8080:8080 \
  --link helpdesk-mysql:mysql \
  java-faces-crud:latest
```

### Viewing Logs

```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f app
docker compose logs -f mysql
docker compose logs -f flyway

# Application only
docker logs -f helpdesk-app
```

### Rebuilding After Code Changes

```bash
# Rebuild and restart
docker compose up -d --build

# Force rebuild without cache
docker compose build --no-cache
docker compose up -d
```

## Environment Variables

The application supports the following environment variables:

| Variable    | Default   | Description       |
| ----------- | --------- | ----------------- |
| DB_HOST     | mysql     | MySQL hostname    |
| DB_PORT     | 3306      | MySQL port        |
| DB_NAME     | helpdesk  | Database name     |
| DB_USER     | root      | Database username |
| DB_PASSWORD | A_1234567 | Database password |

### Customizing Configuration

Create a `.env` file in the project root:

```env
DB_HOST=mysql
DB_PORT=3306
DB_NAME=helpdesk
DB_USER=root
DB_PASSWORD=your_secure_password
```

Then update `docker compose.yml` to use these variables or pass them directly:

```bash
DB_PASSWORD=my_password docker compose up -d
```

## Troubleshooting

### Application Won't Start

1. Check if MySQL is healthy:

   ```bash
   docker compose ps
   ```

2. View application logs:

   ```bash
   docker compose logs app
   ```

3. Verify database connection:
   ```bash
   docker exec -it helpdesk-mysql mysql -uroot -pA_1234567 -e "SHOW DATABASES;"
   ```

### Database Connection Errors

1. Ensure MySQL container is running:

   ```bash
   docker compose ps mysql
   ```

2. Check network connectivity:

   ```bash
   docker exec -it helpdesk-app ping mysql
   ```

3. Verify database credentials in docker compose.yml

### Migration Failures

1. Check Flyway logs:

   ```bash
   docker compose logs flyway
   ```

2. Manually run migrations:

   ```bash
   docker compose up flyway
   ```

3. Reset database (⚠️ destroys data):
   ```bash
   docker compose down -v
   docker compose up -d
   ```

### Port Conflicts

If ports 8080 or 3306 are already in use, modify `docker compose.yml`:

```yaml
services:
  app:
    ports:
      - "8081:8080" # Use port 8081 on host
  mysql:
    ports:
      - "3307:3306" # Use port 3307 on host
```

## Production Considerations

### Security

1. **Change default passwords** in production:

   ```yaml
   environment:
     MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
     DB_PASSWORD: ${DB_PASSWORD}
   ```

2. **Use secrets management** for sensitive data

3. **Disable root access** - use dedicated application user

### Performance

1. **Resource limits** in docker compose.yml:

   ```yaml
   services:
     app:
       deploy:
         resources:
           limits:
             cpus: "2"
             memory: 2G
   ```

2. **Connection pooling** - configure in persistence.xml

3. **Volume optimization** - use named volumes for better performance

### Monitoring

1. **Health checks** for the application:

   ```yaml
   app:
     healthcheck:
       test: ["CMD", "curl", "-f", "http://localhost:8080/java-faces-crud/"]
       interval: 30s
       timeout: 10s
       retries: 3
   ```

2. **Container stats**:
   ```bash
   docker stats
   ```

## Multi-Stage Build Optimization

The Dockerfile uses multi-stage builds to:

- Minimize final image size
- Separate build and runtime dependencies
- Improve build caching

Build stages:

1. **builder** - Compiles Java code and packages WAR
2. **runtime** - Runs application in Tomcat

## Volume Management

### Backup Database

```bash
docker exec helpdesk-mysql mysqldump -uroot -pA_1234567 helpdesk > backup.sql
```

### Restore Database

```bash
docker exec -i helpdesk-mysql mysql -uroot -pA_1234567 helpdesk < backup.sql
```

### Inspect Volumes

```bash
docker volume ls
docker volume inspect java-faces-crud_mysql_data
```

## Development Workflow with Docker

1. Make code changes
2. Rebuild and restart:
   ```bash
   docker compose up -d --build app
   ```
3. View logs:
   ```bash
   docker compose logs -f app
   ```
4. Access application at http://localhost:8080/java-faces-crud/tickets.jsp

## Cleaning Up

Remove all containers, networks, and volumes:

```bash
docker compose down -v
docker system prune -a
```

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Tomcat Docker Images](https://hub.docker.com/_/tomcat)
- [MySQL Docker Images](https://hub.docker.com/_/mysql)
