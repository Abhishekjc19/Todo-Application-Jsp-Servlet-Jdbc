# Library Setup Guide

## Required JAR Files

This application requires the following JAR files in `WebContent/WEB-INF/lib/` directory:

### 1. Oracle JDBC Driver (Required)
- **File:** `ojdbc8.jar` or `ojdbc11.jar`
- **Purpose:** Connect to Oracle Database
- **Download:** 
  - Oracle Database 11g/12c: Use `ojdbc8.jar`
  - Oracle Database 18c+: Use `ojdbc11.jar`
  - Download from: [Oracle JDBC Downloads](https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html)
  
  Or use Maven coordinates:
  ```xml
  <dependency>
      <groupId>com.oracle.database.jdbc</groupId>
      <artifactId>ojdbc8</artifactId>
      <version>21.1.0.0</version>
  </dependency>
  ```

### 2. JSTL Library (Included)
- **File:** `jstl-1.2.jar`
- **Purpose:** JSP Standard Tag Library for dynamic content
- **Status:** ✅ Already included in project

### 3. Servlet API (Included)
- **File:** `servlet-api-2.5.jar`
- **Purpose:** Java Servlet API
- **Status:** ✅ Already included in project
- **Note:** Provided by Tomcat at runtime, needed only for compilation

### 4. JSP API (Included)
- **File:** `jsp-api-2.2.jar`
- **Purpose:** JavaServer Pages API
- **Status:** ✅ Already included in project
- **Note:** Provided by Tomcat at runtime, needed only for compilation

## How to Add JAR Files

### Method 1: Eclipse IDE
1. Download the required JAR file
2. Copy the JAR to `WebContent/WEB-INF/lib/`
3. Right-click on the project → `Properties`
4. Select `Java Build Path` → `Libraries` tab
5. Click `Add JARs...` (or `Add External JARs...`)
6. Select the JAR file from `WEB-INF/lib/`
7. Click `OK`

### Method 2: Direct Copy
1. Download the required JAR file
2. Copy to: `WebContent/WEB-INF/lib/`
3. Clean and rebuild the project

## Verify Installation

After adding the libraries:

1. **Check Build Path:**
   - Right-click project → `Properties` → `Java Build Path` → `Libraries`
   - Ensure all JARs are listed

2. **Check Deployment:**
   - Expand `WebContent/WEB-INF/lib/` in Project Explorer
   - All required JARs should be visible

3. **Test Connection:**
   - Run the application
   - Try to login with default credentials
   - If successful, JDBC driver is working correctly

## Troubleshooting

### ClassNotFoundException: oracle.jdbc.driver.OracleDriver
**Cause:** Oracle JDBC driver not found  
**Solution:** 
- Download `ojdbc8.jar` or `ojdbc11.jar`
- Place in `WebContent/WEB-INF/lib/`
- Add to build path
- Clean and rebuild project

### NoClassDefFoundError: javax/servlet/jsp/jstl/core/Config
**Cause:** JSTL library missing  
**Solution:** Verify `jstl-1.2.jar` is in `WEB-INF/lib/`

### Deployment Error
**Cause:** JAR files not deployed with application  
**Solution:** 
- Ensure JARs are in `WEB-INF/lib/` (not in a different location)
- Clean Tomcat work directory
- Redeploy the application

## Maven Alternative (Optional)

If you prefer using Maven, create `pom.xml`:

```xml
<dependencies>
    <!-- Oracle JDBC Driver -->
    <dependency>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc8</artifactId>
        <version>21.1.0.0</version>
    </dependency>
    
    <!-- JSTL -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>
    
    <!-- Servlet API -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>3.1.0</version>
        <scope>provided</scope>
    </dependency>
    
    <!-- JSP API -->
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>javax.servlet.jsp-api</artifactId>
        <version>2.3.1</version>
        <scope>provided</scope>
    </dependency>
</dependencies>
```

---

**Note:** Keep JAR files out of version control if they are large. Update `.gitignore` accordingly.
