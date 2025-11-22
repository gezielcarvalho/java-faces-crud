# Java Faces CRUD - Helpdesk Ticket Management

A Java web application for managing helpdesk tickets, built with JavaServer Pages (JSP), JPA/Hibernate, and MySQL. This project demonstrates CRUD operations, database migration management with Flyway, and deployment to Tomcat servers.

## Overview

This application provides a simple ticket management system where users can:

- View all helpdesk tickets
- Track ticket status (OPEN, IN_PROGRESS, RESOLVED, CLOSED)
- Manage tickets with full CRUD operations
- Persist data using JPA/Hibernate with MySQL

## Technology Stack

- **Java**: 21
- **Build Tool**: Maven
- **Web Framework**: JavaServer Pages (JSP)
- **ORM**: Hibernate 5.4.30 (JPA 2.2)
- **Database**: MySQL 8.0.20
- **Migration Tool**: Flyway 9.0.0
- **Logging**: SLF4J with Log4j2
- **Server**: Apache Tomcat 7+

## Project Structure

```
java-faces-crud/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── info/gezielcarvalho/
│   │   │       ├── entity/
│   │   │       │   ├── Ticket.java       # JPA Entity for tickets
│   │   │       │   └── Status.java       # Enum for ticket status
│   │   │       └── service/
│   │   │           └── TicketService.java # Service layer for ticket operations
│   │   ├── resources/
│   │   │   ├── db/migration/
│   │   │   │   └── V1__Create_And_Seed_Tickets_Table.sql
│   │   │   ├── META-INF/
│   │   │   │   └── persistence.xml       # JPA configuration
│   │   │   ├── log4j2.xml               # Logging configuration
│   │   │   └── import.sql               # Data initialization
│   │   └── webapp/
│   │       ├── index.jsp                # Landing page
│   │       ├── tickets.jsp              # Ticket list view
│   │       └── WEB-INF/
│   │           └── web.xml              # Web application descriptor
│   └── test/java/                       # Unit tests
├── pom.xml                              # Maven configuration
└── README.md
```

## Prerequisites

### Traditional Deployment

- **Java Development Kit (JDK)**: 21 or higher
- **Apache Maven**: 3.6+ for building the project
- **Apache Tomcat**: 7+ (Tomcat 9 recommended) for deployment
- **MySQL**: 8.0+ database server
- **Git**: For version control

### Docker Deployment (Recommended)

- **Docker**: 20.10+
- **Docker Compose**: 2.0+

> 📦 **Quick Start with Docker**: See [Docker Deployment](#docker-deployment-recommended) section below for the fastest way to run this application.

## Database Setup

1. **Install MySQL** (if not already installed)

2. **Create the database**:

   ```sql
   CREATE DATABASE helpdesk;
   ```

3. **Configure database credentials** in two locations:

   **a. JPA Configuration** (`src/main/resources/META-INF/persistence.xml`):

   ```xml
   <property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/helpdesk"/>
   <property name="javax.persistence.jdbc.user" value="root"/>
   <property name="javax.persistence.jdbc.password" value="YOUR_PASSWORD"/>
   ```

   **b. Flyway Configuration** (`pom.xml`):

   ```xml
   <flyway.url>jdbc:mysql://localhost:3306/helpdesk</flyway.url>
   <flyway.user>root</flyway.user>
   <flyway.password>YOUR_PASSWORD</flyway.password>
   ```

4. **Run Flyway migration** to create tables and seed data:
   ```bash
   mvn flyway:migrate
   ```

## Docker Deployment (Recommended)

The easiest way to run this application is using Docker Compose, which handles all dependencies automatically.

### Quick Start

1. **Ensure Docker is running**

2. **Start the application stack**:

   ```bash
   docker compose up -d
   ```

3. **Access the application**:

   - **Home**: http://localhost:8080/java-faces-crud/
   - **Tickets List**: http://localhost:8080/java-faces-crud/tickets.jsp

4. **View logs**:

   ```bash
   docker compose logs -f
   ```

5. **Stop the application**:
   ```bash
   docker compose down
   ```

### What Docker Compose Does

- ✅ Starts MySQL 8.0 database
- ✅ Runs Flyway migrations automatically
- ✅ Builds and deploys the Java application
- ✅ Configures networking between services
- ✅ Sets up persistent storage for database

### Docker Commands

```bash
# View running containers
docker compose ps

# Rebuild after code changes
docker compose up -d --build

# View application logs
docker compose logs -f app

# View database logs
docker compose logs -f mysql

# Stop and remove all containers
docker compose down

# Stop and remove containers + volumes (clears database)
docker compose down -v

# Access MySQL shell
docker exec -it helpdesk-mysql mysql -uroot -pA_1234567 helpdesk
```

### Environment Variables

You can customize the database configuration by setting environment variables:

```bash
DB_HOST=mysql \
DB_PORT=3306 \
DB_NAME=helpdesk \
DB_USER=root \
DB_PASSWORD=your_password \
docker compose up -d
```

📖 **For detailed Docker documentation**, see [DOCKER.md](DOCKER.md)

---

## Project Setup (Traditional Deployment)

> 💡 **Prefer Docker?** Skip this section and use the [Docker Deployment](#docker-deployment-recommended) method above.

### 1. Start Tomcat Server

Make sure your Tomcat server is running and accessible. You can start the server by running the following command:

```bash
/path/to/tomcat/bin/startup.sh

# Windows GitBash Example:
/c/Program\ Files/Java/apache-tomcat-9/bin/startup.sh

# Windows Command Prompt:
C:\Program Files\Java\apache-tomcat-9\bin\startup.bat
```

### 2. Build the Project

To build the project, run the following command:

```bash
mvn clean install
```

This command will compile the source code, run unit tests, and package the application into a WAR file. The WAR file will be located in the `target` directory.

### 3. Deploy to Tomcat

**Option A: Using Maven Plugin**

```bash
mvn tomcat7:deploy
```

**Option B: Manual Deployment**
Copy the generated WAR file to Tomcat's webapps directory:

```bash
cp target/java-faces-crud-1.1-SNAPSHOT.war /path/to/tomcat/webapps/java-faces-crud.war
```

### 4. Access the Application

Once deployed, access the application at:

- **Home**: http://localhost:8080/java-faces-crud/
- **Tickets List**: http://localhost:8080/java-faces-crud/tickets.jsp

### 5. Stop Tomcat Server

When you don't need the Tomcat server anymore, you can stop it by running the following command:

```bash
/path/to/tomcat/bin/shutdown.sh

# Windows GitBash Example:
/c/Program\ Files/Java/apache-tomcat-9/bin/shutdown.sh

# Windows Command Prompt:
C:\Program Files\Java\apache-tomcat-9\bin\shutdown.bat
```

## Monitoring and Logging

### View Application Logs

To monitor the logs in real-time, use the following command:

```bash
less +F /path/to/tomcat/logs/catalina.out

# Windows GitBash Example:
less +F /c/Program\ Files/Java/apache-tomcat-9/logs/catalina.out
```

### Log Configuration

The application uses Log4j2 for logging. Configuration is in `src/main/resources/log4j2.xml`. Current logging includes:

- SQL queries (via `hibernate.show_sql`)
- Service layer operations
- Database interactions

## Database Migrations

This project uses **Flyway** for database version control and migrations.

### Available Flyway Commands

```bash
# Run all pending migrations
mvn flyway:migrate

# Get migration status
mvn flyway:info

# Validate applied migrations
mvn flyway:validate

# Clean database (use with caution!)
mvn flyway:clean
```

### Migration Files

Migration scripts are located in `src/main/resources/db/migration/`:

- `V1__Create_And_Seed_Tickets_Table.sql` - Initial schema and sample data

## Core Features

### Entity Model

**Ticket Entity** (`info.gezielcarvalho.entity.Ticket`):

- `id`: Auto-generated primary key
- `title`: Ticket title (VARCHAR 255)
- `description`: Detailed description (TEXT)
- `status`: Ticket status (ENUM)
- `createdDate`: Timestamp of creation

**Status Enum** (`info.gezielcarvalho.entity.Status`):

- `OPEN` - New ticket
- `IN_PROGRESS` - Being worked on
- `RESOLVED` - Solution implemented
- `CLOSED` - Completed and closed

### Service Layer

**TicketService** (`info.gezielcarvalho.service.TicketService`):

- `getAllTickets()` - Retrieve all tickets from database
- `createTicket(Ticket)` - Persist new ticket

## Maven Configuration

### Build Properties

```xml
<maven.compiler.source>21</maven.compiler.source>
<maven.compiler.target>21</maven.compiler.target>
<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
```

### Key Dependencies

| Dependency            | Version | Purpose                               |
| --------------------- | ------- | ------------------------------------- |
| javax.servlet-api     | 4.0.1   | Java Servlet API (provided by Tomcat) |
| javax.persistence-api | 2.2     | JPA API for object-relational mapping |
| hibernate-core        | 5.4.30  | JPA implementation and ORM framework  |
| mysql-connector-java  | 8.0.20  | MySQL JDBC driver                     |
| flyway-core           | 9.0.0   | Database migration framework          |
| flyway-mysql          | 9.0.0   | MySQL-specific Flyway support         |
| slf4j-api             | 1.7.36  | Logging facade                        |
| log4j-slf4j-impl      | 2.17.2  | Log4j2 binding for SLF4J              |
| log4j-api             | 2.17.2  | Log4j2 API                            |
| log4j-core            | 2.17.2  | Log4j2 implementation                 |

### Maven Plugins

| Plugin               | Version | Purpose                    |
| -------------------- | ------- | -------------------------- |
| tomcat7-maven-plugin | 2.2     | Deploy to Tomcat server    |
| flyway-maven-plugin  | 9.0.0   | Manage database migrations |

## Troubleshooting

### Common Issues

**1. Database Connection Errors**

- Verify MySQL is running: `mysql -u root -p`
- Check credentials in `persistence.xml` and `pom.xml`
- Ensure database `helpdesk` exists

**2. Tomcat Deployment Failures**

- Verify Tomcat is running on port 8080
- Check Tomcat manager credentials in Maven settings (`~/.m2/settings.xml`)
- Ensure no port conflicts

**3. Build Failures**

- Verify Java 21 is installed: `java -version`
- Clean Maven cache: `mvn clean`
- Update dependencies: `mvn dependency:resolve`

**4. Migration Errors**

- Check Flyway configuration in `pom.xml`
- Verify migration files in `src/main/resources/db/migration/`
- Review migration status: `mvn flyway:info`

## Development Workflow

1. **Make code changes**
2. **Run Flyway migrations** (if database schema changed):
   ```bash
   mvn flyway:migrate
   ```
3. **Build the project**:
   ```bash
   mvn clean package
   ```
4. **Deploy to Tomcat**:
   ```bash
   mvn tomcat7:redeploy
   ```
5. **Test the application** at http://localhost:8080/java-faces-crud/tickets.jsp

## Future Enhancements

Potential improvements for this project:

- Implement full CRUD operations (Update, Delete)
- Add form validation
- Implement user authentication and authorization
- Add REST API endpoints
- Migrate to modern frameworks (Spring Boot, JSF 2.3+)
- Add comprehensive unit and integration tests
- Implement pagination for ticket list
- Add search and filter capabilities

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available for educational purposes.

## Contact

**Author**: Geziel Carvalho  
**Repository**: https://github.com/gezielcarvalho/java-faces-crud

---

**Version**: 1.1-SNAPSHOT  
**Last Updated**: November 2025
