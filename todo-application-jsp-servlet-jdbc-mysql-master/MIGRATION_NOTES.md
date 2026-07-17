# Migration from MySQL to Oracle SQL

This document outlines all the changes made to migrate the Todo Application from MySQL to Oracle Database.

## 🔄 Summary of Changes

### Database Changes

#### 1. SQL Script (`script_oracle.sql`)
**New file created for Oracle Database**

**Key Differences from MySQL:**

| Feature | MySQL | Oracle |
|---------|-------|--------|
| Auto-increment | `AUTO_INCREMENT` | `SEQUENCE` + `TRIGGER` |
| Boolean type | `BIT(1)` | `NUMBER(1)` with CHECK constraint |
| String types | `VARCHAR(n)` | `VARCHAR2(n)` |
| Date/Time | `DATETIME(6)` | `DATE` or `TIMESTAMP` |
| Table engine | `ENGINE=InnoDB` | Not needed |
| Character set | `CHARSET=utf8mb4` | Set at database level |

**Oracle-Specific Features Added:**
- ✅ Sequences for auto-increment (`users_seq`, `todos_seq`)
- ✅ Triggers for auto-populating IDs (`users_bir`, `todos_bir`)
- ✅ CHECK constraints for boolean values
- ✅ Proper data types (VARCHAR2, NUMBER, DATE)
- ✅ Indexes for performance optimization
- ✅ Sample data insertion
- ✅ Verification queries

**MySQL Script Structure:**
```sql
CREATE TABLE users (
  id int(3) NOT NULL AUTO_INCREMENT,
  ...
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

**Oracle Script Structure:**
```sql
-- Create table
CREATE TABLE users (
    id NUMBER(10) PRIMARY KEY,
    ...
);

-- Create sequence
CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;

-- Create trigger for auto-increment
CREATE OR REPLACE TRIGGER users_bir 
BEFORE INSERT ON users 
FOR EACH ROW
BEGIN
    IF :new.id IS NULL THEN
        SELECT users_seq.NEXTVAL INTO :new.id FROM dual;
    END IF;
END;
/
```

### Java Code Changes

#### 2. `JDBCUtils.java`
**Purpose:** Database connection configuration

**Changed:**
```java
// OLD (MySQL)
private static String jdbcURL = "jdbc:mysql://localhost:3306/todo_management";
private static String jdbcUsername = "root";
private static String jdbcPassword = "root";
Class.forName("com.mysql.jdbc.Driver");

// NEW (Oracle)
private static String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
private static String jdbcUsername = "todo_user";
private static String jdbcPassword = "todo_password";
Class.forName("oracle.jdbc.driver.OracleDriver");
```

**Added:** Detailed comments explaining Oracle connection string format

#### 3. `LoginDao.java`
**Purpose:** User authentication

**Changed:**
```java
// OLD
Class.forName("com.mysql.jdbc.Driver");

// NEW
Class.forName("oracle.jdbc.driver.OracleDriver");
```

#### 4. Other DAO Files
**Files:** `TodoDaoImpl.java`, `UserDao.java`, `TodoDao.java`

**No SQL changes required!** 
- Standard JDBC SQL queries work on both MySQL and Oracle
- Parameterized queries are database-agnostic
- Date handling remains the same

**Example (works on both):**
```java
String INSERT_TODOS_SQL = "INSERT INTO todos (title, username, description, target_date, is_done) VALUES (?, ?, ?, ?, ?)";
```

### Library Changes

#### 5. JDBC Driver
**Removed:**
- ❌ `mysql-connector-java-8.0.13.jar`

**Required (User must download):**
- ✅ `ojdbc8.jar` (Oracle 11g/12c/18c)
- ✅ `ojdbc11.jar` (Oracle 19c+)

**Kept (unchanged):**
- ✅ `jstl-1.2.jar`
- ✅ `servlet-api-2.5.jar`
- ✅ `jsp-api-2.2.jar`

## 📁 New Documentation Files

### 1. `README.md` (Enhanced)
Comprehensive documentation including:
- ✅ Features overview with emojis
- ✅ Technology stack
- ✅ Detailed installation instructions
- ✅ Oracle database setup guide
- ✅ Application structure
- ✅ Usage guide with screenshots descriptions
- ✅ Troubleshooting section
- ✅ Contributing guidelines reference
- ✅ License information
- ✅ Author details
- ✅ GitHub badges

### 2. `QUICK_START.md` (New)
- ⚡ 5-minute setup guide
- ✅ Step-by-step instructions
- ✅ Quick troubleshooting tips
- ✅ Default credentials

### 3. `LIBRARY_SETUP.md` (New)
- 📚 Detailed JAR file requirements
- ✅ Download links for Oracle JDBC driver
- ✅ Eclipse setup instructions
- ✅ Maven alternative configuration
- ✅ Troubleshooting library issues

### 4. `CONTRIBUTING.md` (New)
- 🤝 Contribution guidelines
- ✅ Code style guidelines
- ✅ Commit message conventions
- ✅ Pull request process
- ✅ Code of conduct

### 5. `LICENSE` (New)
- ⚖️ MIT License
- ✅ Copyright information

### 6. `.gitignore` (New)
- 🚫 Excludes compiled files, IDE configs, build artifacts
- ✅ Tailored for Java/Eclipse/Maven projects

## 🔧 Configuration Requirements

### Before Running

**Users must configure:**

1. **Database Connection** in `JDBCUtils.java`:
   ```java
   private static String jdbcURL = "jdbc:oracle:thin:@[HOST]:[PORT]:[SID]";
   private static String jdbcUsername = "[YOUR_USERNAME]";
   private static String jdbcPassword = "[YOUR_PASSWORD]";
   ```

2. **Oracle JDBC Driver**:
   - Download `ojdbc8.jar` or `ojdbc11.jar`
   - Place in `WebContent/WEB-INF/lib/`

3. **Run Database Script**:
   ```sql
   @script_oracle.sql
   ```

## 🆚 MySQL vs Oracle Comparison

### Connection Strings
```
MySQL:    jdbc:mysql://localhost:3306/database_name
Oracle:   jdbc:oracle:thin:@localhost:1521:SID
```

### Data Types
| MySQL | Oracle | Notes |
|-------|--------|-------|
| INT | NUMBER | Oracle uses NUMBER for all numeric types |
| VARCHAR | VARCHAR2 | Oracle requires VARCHAR2 |
| DATETIME | DATE or TIMESTAMP | Oracle DATE includes time |
| BIT | NUMBER(1) | Use 0/1 with CHECK constraint |
| AUTO_INCREMENT | SEQUENCE + TRIGGER | Oracle requires explicit setup |

### SQL Syntax Differences
| Feature | MySQL | Oracle |
|---------|-------|--------|
| String concat | CONCAT() or \|\| | \|\| or CONCAT |
| Limit | LIMIT n | ROWNUM <= n or FETCH FIRST |
| If-then | IF() | CASE or DECODE |
| Auto-increment | Built-in | Manual sequences |
| Current time | NOW() | SYSDATE or CURRENT_TIMESTAMP |

## ✅ Testing Checklist

After migration, verify:

- [ ] Database connection successful
- [ ] User registration works
- [ ] Login/logout functions correctly
- [ ] Add new todo works
- [ ] Edit todo works
- [ ] Delete todo works
- [ ] View all todos works
- [ ] Date formatting displays correctly
- [ ] Boolean (is_done) works correctly
- [ ] Session management functions
- [ ] No console errors

## 🐛 Common Migration Issues

### 1. ORA-00904: Invalid identifier
**Cause:** Column name doesn't exist or typo  
**Solution:** Verify table structure with `DESC table_name`

### 2. ORA-00942: Table or view does not exist
**Cause:** Script not run or wrong schema  
**Solution:** Run `script_oracle.sql` and verify connection user

### 3. ORA-02289: Sequence does not exist
**Cause:** Sequences not created  
**Solution:** Verify trigger creation in script

### 4. ClassNotFoundException: oracle.jdbc.driver.OracleDriver
**Cause:** JDBC driver not in classpath  
**Solution:** Add `ojdbc8.jar` to `WEB-INF/lib/`

### 5. Auto-increment not working
**Cause:** Trigger not created or not firing  
**Solution:** Verify trigger status:
```sql
SELECT trigger_name, status FROM user_triggers WHERE table_name = 'USERS';
```

## 📊 Performance Considerations

**Oracle Optimizations Added:**
- Indexes on frequently queried columns (username, target_date)
- Sequences with NOCACHE for better sequence number allocation
- Check constraints for data integrity
- Proper data types for optimal storage

## 🔐 Security Notes

**Important:**
- Default credentials in `script_oracle.sql` are for development only
- Change admin password before production deployment
- Use environment variables for database credentials in production
- Never commit `JDBCUtils.java` with real credentials to public repos

## 📞 Support

For migration-related issues:
1. Check Oracle Database is running: `lsnrctl status`
2. Verify connection details in `JDBCUtils.java`
3. Review Oracle error codes: https://docs.oracle.com/en/error-help/
4. Open an issue on GitHub with error details

## 🎓 Learning Resources

- [Oracle SQL Tutorial](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/)
- [Oracle JDBC Developer's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/21/jjdbc/)
- [MySQL to Oracle Migration Guide](https://www.oracle.com/database/technologies/mysql-to-oracle-migration.html)

---

**Migration completed successfully!** 🎉

All files have been pushed to GitHub: https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc
