# 🚀 Quick Start Guide

Get up and running with the Todo Application in 5 minutes!

## Prerequisites Checklist

- [ ] Java JDK 8+ installed
- [ ] Apache Tomcat 8.5+ installed
- [ ] Oracle Database 11g+ installed and running
- [ ] Eclipse IDE (or IntelliJ IDEA)

## 5-Minute Setup

### Step 1: Clone the Repository (1 min)

```bash
git clone https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc.git
cd Todo-Application-Jsp-Servlet-Jdbc
```

### Step 2: Setup Oracle Database (2 min)

#### Connect to Oracle
```bash
# Windows
sqlplus username/password@localhost:1521/XE

# Or use SQL Developer GUI
```

#### Run Database Script
```sql
@script_oracle.sql
```

**That's it!** The script creates:
- ✅ `users` table with sequences and triggers
- ✅ `todos` table with sequences and triggers
- ✅ Sample data (admin user + 2 todos)
- ✅ Indexes for performance

### Step 3: Configure Database Connection (1 min)

Edit `src/net/javaguides/todoapp/utils/JDBCUtils.java`:

```java
private static String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
private static String jdbcUsername = "your_username";
private static String jdbcPassword = "your_password";
```

**Replace:**
- `your_username` with your Oracle username
- `your_password` with your Oracle password
- `localhost:1521:XE` if different

### Step 4: Add Oracle JDBC Driver (1 min)

1. Download `ojdbc8.jar` from [Oracle JDBC Downloads](https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html)
2. Copy to `WebContent/WEB-INF/lib/ojdbc8.jar`
3. **Done!** Other libraries are already included.

### Step 5: Import & Run (2 min)

#### In Eclipse:
1. `File` → `Import` → `Existing Projects into Workspace`
2. Select the project folder
3. Right-click project → `Run As` → `Run on Server`
4. Select Tomcat 8.5+
5. Click `Finish`

#### In IntelliJ IDEA:
1. `File` → `Open` → Select project folder
2. Add Tomcat configuration
3. Click `Run` ▶️

---

## 🎉 You're Done!

Open your browser: **http://localhost:8080/todo-application/**

### Login with Default Credentials:
- **Username:** `admin`
- **Password:** `admin123`

---

## 🆘 Quick Troubleshooting

### Can't connect to database?
```bash
# Check if Oracle is running
lsnrctl status

# Verify connection
sqlplus username/password@localhost:1521/XE
```

### ClassNotFoundException: oracle.jdbc.driver.OracleDriver?
➡️ Make sure `ojdbc8.jar` is in `WebContent/WEB-INF/lib/`

### Tables don't exist?
➡️ Run `script_oracle.sql` again:
```sql
@script_oracle.sql
```

### Port 8080 already in use?
➡️ Change Tomcat port in `server.xml` or stop other services using port 8080

---

## 📚 What's Next?

- 📖 Read the full [README.md](README.md) for detailed documentation
- 🛠️ Check [LIBRARY_SETUP.md](LIBRARY_SETUP.md) for library details
- 🤝 See [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

---

## 💡 Pro Tips

### Using Oracle Express Edition (XE)?
- Default connection: `jdbc:oracle:thin:@localhost:1521:XE`
- Default system password: Set during installation
- Web console: http://localhost:8080/apex

### Using SQL Developer?
1. Create connection with your credentials
2. Run `script_oracle.sql` as script
3. Verify tables created successfully

### Want to create a new user?
```sql
CREATE USER todo_user IDENTIFIED BY todo_password;
GRANT CONNECT, RESOURCE TO todo_user;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO todo_user;
GRANT UNLIMITED TABLESPACE TO todo_user;
```

---

**Need Help?** Open an issue on [GitHub](https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc/issues)

Happy Coding! 🚀
