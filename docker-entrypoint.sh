#!/bin/bash
# Script to set database connection based on environment variables

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"
DB_NAME="${DB_NAME:-helpdesk}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-A_1234567}"

PERSISTENCE_XML="/usr/local/tomcat/webapps/java-faces-crud/WEB-INF/classes/META-INF/persistence.xml"

echo "Starting Tomcat..."
catalina.sh start

# Wait for the WAR to be deployed
echo "Waiting for application deployment..."
while [ ! -f "$PERSISTENCE_XML" ]; do
  sleep 2
done

echo "Updating database configuration..."
sed -i "s|jdbc:mysql://[^/]*|jdbc:mysql://${DB_HOST}:${DB_PORT}|g" "$PERSISTENCE_XML"
sed -i "s|<property name=\"javax.persistence.jdbc.user\" value=\"[^\"]*\"|<property name=\"javax.persistence.jdbc.user\" value=\"${DB_USER}\"|g" "$PERSISTENCE_XML"
sed -i "s|<property name=\"javax.persistence.jdbc.password\" value=\"[^\"]*\"|<property name=\"javax.persistence.jdbc.password\" value=\"${DB_PASSWORD}\"|g" "$PERSISTENCE_XML"

echo "Database configuration updated successfully!"
echo "Application is ready!"

# Keep the container running by tailing Tomcat logs
tail -f /usr/local/tomcat/logs/catalina.out
