# Java Faces Project

This project is a Java web application that uses JavaServer Faces (JSF) for the user interface. The project is built with Maven and uses Hibernate for database interaction. The project is configured to deploy to a Tomcat 7 server.

# Project Structure

The project is structured as follows:

- **src/main/java**: Contains Java source code.
- **src/main/resources**: Contains configuration files and resources.
- **src/main/webapp**: Contains web resources (JSP, CSS, JavaScript, etc.).
- **src/test/java**: Contains unit tests.
- **src/test/resources**: Contains test resources.
- **target**: Contains build output (compiled classes, JARs, WARs, etc.).
- **pom.xml**: Maven project configuration file.
- **README.md**: This file.

# Project Setup

To build the project, run the following command:

```bash
mvn clean install
```

This command will compile the source code, run unit tests, and package the application into a WAR file. The WAR file will be located in the `target` directory.

To deploy the application to a Tomcat 7 server, run the following command:

```bash
mvn tomcat7:deploy
```

This command will deploy the application to the Tomcat 7 server configured in the `pom.xml` file.

# Monitoring the logs

To monitor the logs, you can use the following command:

```bash
less +F /path/to/tomcat/logs/catalina.out

# GitBash Example: less +F /c/ProgramFiles/Java/apache-tomcat-9/logs/catalina.out
```

The "Status" column has values of **yes** (if present in `pom.xml`), **no** (if listed in the table but not in `pom.xml`), or **new** (if present in `pom.xml` but not in the table).

# Project Dependencies and Plugins

| Type             | Name                  | Version     | Description                                                   | Status |
| ---------------- | --------------------- | ----------- | ------------------------------------------------------------- | ------ |
| **Plugins**      |                       |             |                                                               |        |
|                  | maven-surefire-plugin | Latest      | Runs unit tests as part of the build process.                 | no     |
|                  | maven-jetty-plugin    | 6.1.11      | Enables running web applications in Jetty during development. | no     |
|                  | maven-compiler-plugin | 1.8         | Compiles source code with specified Java version.             | no     |
|                  | maven-eclipse-plugin  | 2.9         | Integrates Maven projects with Eclipse IDE.                   | no     |
|                  | maven-war-plugin      | 3.3.1       | Packages applications into WAR files for deployment.          | no     |
|                  | tomcat7-maven-plugin  | 2.2         | Deploys applications to Tomcat 7 server.                      | yes    |
|                  | tomcat-maven-plugin   | 2.2         | Configures and deploys Tomcat instances.                      | no     |
|                  | maven-t7-plugin       | 0.9.18      | Simplifies Tomcat 7 setup and deployment.                     | no     |
|                  | flyway-maven-plugin   | 9.0.0       | Manages database migrations.                                  | new    |
| **Extensions**   |                       |             |                                                               |        |
|                  | wagon-ftp             | 1.0-beta-6  | Provides FTP support for file transfer in Maven.              | no     |
| **Dependencies** |                       |             |                                                               |        |
|                  | xercesImpl            | 2.11.0      | XML parser for Java, supporting DOM, SAX, and JAXP.           | no     |
|                  | javamelody-core       | 1.74.0      | Monitors Java applications in production.                     | no     |
|                  | ecj                   | 4.4         | Eclipse Compiler for Java.                                    | no     |
|                  | mve12                 | 2.1.8.final | Maven integration for enterprise applications.                | no     |
|                  | joda-time             | 1.6         | Provides advanced date and time management.                   | no     |
|                  | xstream               | 1.4.20      | Converts Java objects to XML and back.                        | no     |
|                  | jrobin                | 1.5.9       | A Java implementation of RRDTool for time-series data.        | no     |
|                  | itext                 | 2.1.7       | PDF creation library.                                         | no     |
|                  | jakarta-xml-bind-api  | 2.3.3       | XML binding for Java API.                                     | no     |
|                  | javax.servlet-api     | 4.0.1       | Java Servlet API for building web applications.               | yes    |
|                  | el-api                | 1.0         | Expression Language API used in JSPs.                         | no     |
|                  | jboss-seam-mail       | Latest      | Provides email support for JBoss Seam applications.           | no     |
|                  | testng                | 5.8         | Testing framework for Java applications.                      | no     |
|                  | c3p0                  | 0.9.1.2     | JDBC connection pooling library.                              | no     |
|                  | hibernate-cp30        | 3.6.8       | C3P0 integration with Hibernate ORM.                          | no     |
|                  | mysql-connector-java  | 8.0.20      | MySQL JDBC driver for database connectivity.                  | yes    |
|                  | commons-logging       | 1.1.1       | Logging facade for Java applications.                         | no     |
|                  | commons-lang          | 2.4         | Utilities for manipulating core Java classes.                 | no     |
|                  | jboss-seam            | Latest      | Framework for integrating Java EE and Web applications.       | no     |
|                  | jboss-el              | Latest      | Expression Language implementation for JBoss.                 | no     |
|                  | jboss-seam-ui         | Latest      | UI components for JBoss Seam.                                 | no     |
|                  | hibernate-jpa-2.0-api | 1.0.0.Final | Java Persistence API for Hibernate.                           | no     |
|                  | hibernate-core        | Latest      | Core Hibernate ORM framework for database interaction.        | yes    |
|                  | hibernate-envers      | Latest      | Audit trail support for Hibernate entities.                   | no     |
|                  | solr-common           | 1.3.0       | Common library for Apache Solr.                               | no     |
|                  | solr-core             | 1.4.0       | Core search functionalities for Apache Solr.                  | no     |
|                  | lucene-snowball       | 3.0.3       | Stemming library for Apache Lucene.                           | no     |
|                  | quartz                | 1.8.5       | Scheduling library for Java applications.                     | no     |
|                  | commons-pool          | 1.5.6       | Pooling utilities for Java objects.                           | no     |
|                  | bsh                   | 1.3.0       | BeanShell scripting language for Java.                        | no     |
|                  | commons-collections   | 3.2         | Java collections framework utilities.                         | no     |
|                  | jsf-api               | 1.2_15      | JavaServer Faces API for UI components.                       | no     |
|                  | jsf-impl              | 1.2_15      | JSF implementation for web applications.                      | no     |
|                  | jstl                  | 1.2         | JSP Standard Tag Library.                                     | no     |
|                  | slf4j-api             | 1.7.36      | Simple Logging Facade for Java.                               | no     |
|                  | log4j-slf4j-impl      | 2.17.2      | Log4j integration with SLF4J.                                 | no     |
|                  | jasperreports         | 4.5.1       | Reporting library for Java applications.                      | no     |
|                  | poi                   | 3.7         | Library for manipulating Microsoft Office documents.          | no     |
|                  | drools-core           | Latest      | Core components for the Drools rule engine.                   | no     |
|                  | jasypt-hibernate3     | 1.9.0       | Encryption library for Hibernate data.                        | no     |
|                  | super-csv             | 2.2.1       | CSV parsing library for Java.                                 | no     |
|                  | slf4j-log4j12         | 1.7.36      | SLF4J binding for Log4j.                                      | no     |
|                  | log4j-api             | 2.17.1      | API for Log4j logging framework.                              | no     |
|                  | flyway-core           | 9.0.0       | Library for managing database migrations.                     | new    |
|                  | flyway-mysql          | 9.0.0       | MySQL-specific Flyway support.                                | new    |
