# 🚀 Quick Start Guide - Java Faces CRUD

## Docker (Recommended - 3 Steps)

```bash
# 1. Start everything
docker compose up -d

# 2. Access the app
# Open: http://localhost:8080/java-faces-crud/tickets.jsp

# 3. Stop everything
docker compose down
```

## What's Included?

✅ MySQL 8.0 Database  
✅ Automatic database migrations (Flyway)  
✅ Java application on Tomcat  
✅ All dependencies configured

## Useful Commands

```bash
# View logs
docker compose logs -f app

# Rebuild after changes
docker compose up -d --build

# Reset everything (removes data!)
docker compose down -v

# Access database
docker exec -it helpdesk-mysql mysql -uroot -pA_1234567 helpdesk
```

## Project Structure

```
📦 java-faces-crud
├── 🐳 Dockerfile              # Application container definition
├── 🐳 docker-compose.yml      # Multi-container orchestration
├── 🐳 docker-entrypoint.sh    # Startup script
├── 📖 DOCKER.md               # Detailed Docker guide
├── 📋 README.md               # Main documentation
│
├── src/main/
│   ├── java/
│   │   └── info/gezielcarvalho/
│   │       ├── entity/        # JPA entities (Ticket, Status)
│   │       └── service/       # Business logic
│   ├── resources/
│   │   ├── db/migration/      # Database version control
│   │   └── META-INF/          # JPA configuration
│   └── webapp/                # JSP pages
│
└── pom.xml                    # Maven dependencies
```

## Environment Variables

Create `.env` file (copy from `.env.example`):

```env
DB_HOST=mysql
DB_PORT=3306
DB_NAME=helpdesk
DB_USER=root
DB_PASSWORD=your_secure_password
```

## Troubleshooting

**Port already in use?**

```bash
# Check what's using port 8080
netstat -ano | findstr :8080

# Or use different port in docker-compose.yml:
# ports: - "8081:8080"
```

**Database connection failed?**

```bash
# Check MySQL is healthy
docker compose ps

# View MySQL logs
docker compose logs mysql
```

**Need to rebuild?**

```bash
# Force clean rebuild
docker compose build --no-cache
docker compose up -d
```

## Next Steps

1. 📖 Read [DOCKER.md](DOCKER.md) for advanced Docker usage
2. 📖 Read [README.md](README.md) for traditional deployment
3. 🔨 Make code changes and rebuild with `docker compose up -d --build`
4. 🧪 Add tests and run them in the container

## Tech Stack

- ☕ Java 21
- 🌐 JavaServer Pages (JSP)
- 🗄️ MySQL 8.0
- 🔄 Hibernate (JPA)
- 📦 Maven
- 🐳 Docker & Docker Compose
- 🚀 Apache Tomcat 9

---

**Happy Coding! 🎉**
