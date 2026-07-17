# 📝 Todo Application - JSP Servlet JDBC Oracle

A full-stack web application for managing todos built with Java EE technologies and Oracle Database. This application demonstrates MVC architecture with JSP, Servlets, and JDBC for database operations.

![Java](https://img.shields.io/badge/Java-8%2B-orange)
![JSP](https://img.shields.io/badge/JSP-2.3-blue)
![Servlet](https://img.shields.io/badge/Servlet-3.1-blue)
![Oracle](https://img.shields.io/badge/Database-Oracle-red)
![License](https://img.shields.io/badge/License-MIT-green)

## 🌟 Features

- ✅ **User Authentication** - Secure login and registration system
- ✅ **Add Todo** - Create new todo items with title, description, and target date
- ✅ **Edit Todo** - Update existing todo items
- ✅ **List Todos** - View all todos in a responsive table format
- ✅ **Delete Todo** - Remove completed or unwanted todos
- ✅ **Mark as Done** - Track completion status
- ✅ **Responsive Design** - Mobile-friendly UI with Bootstrap
- ✅ **Session Management** - Secure user sessions

## 🛠️ Technology Stack

### Backend
- **Java** 8+
- **JSP** (JavaServer Pages) 2.3
- **Servlet** 3.1
- **JDBC** for database connectivity
- **Oracle Database** 11g or higher

### Frontend
- **HTML5** & **CSS3**
- **Bootstrap** 4 (Responsive Design)
- **JSTL** (JSP Standard Tag Library)

### Development Tools
- **Eclipse IDE** / IntelliJ IDEA
- **Apache Tomcat** 8.5+
- **Maven** (optional for dependency management)

## 📋 Prerequisites

Before running this application, ensure you have the following installed:

1. **Java Development Kit (JDK)** 8 or higher
   - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/)
   
2. **Apache Tomcat Server** 8.5 or higher
   - Download from [Apache Tomcat](https://tomcat.apache.org/download-90.cgi)
   
3. **Oracle Database** 11g or higher
   - Download from [Oracle Database](https://www.oracle.com/database/technologies/)
   - Or use Oracle Express Edition (XE) for development
   
4. **Oracle JDBC Driver** (ojdbc8.jar or higher)
   - Included in `WebContent/WEB-INF/lib/` folder

5. **Eclipse IDE for Java EE Developers** (Recommended)
   - Download from [Eclipse](https://www.eclipse.org/downloads/)

## 🚀 Installation & Setup

### 1. Database Setup

#### Step 1: Create Database User (if needed)
```sql
-- Connect as SYSDBA
CREATE USER todo_user IDENTIFIED BY todo_password;
GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO todo_user;
GRANT UNLIMITED TABLESPACE TO todo_user;
```

#### Step 2: Run the Database Script
Connect to Oracle Database and execute the `script_oracle.sql`:

```sql
-- Connect as todo_user or your database user
@script_oracle.sql
```

Or manually create the tables:

```sql
-- Create users table
CREATE TABLE users (
    id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    username VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(50) NOT NULL
);

-- Create sequence for users
CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;

-- Create todos table
CREATE TABLE todos (
    id NUMBER(19) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    username VARCHAR2(100) NOT NULL,
    description VARCHAR2(500),
    target_date DATE,
    is_done NUMBER(1) DEFAULT 0
);

-- Create sequence for todos
CREATE SEQUENCE todos_seq START WITH 1 INCREMENT BY 1;

-- Insert sample user
INSERT INTO users (id, first_name, last_name, username, password) 
VALUES (users_seq.NEXTVAL, 'Admin', 'User', 'admin', 'admin123');

COMMIT;
```

### 2. Configure Database Connection

Update the database connection settings in `src/net/javaguides/todoapp/utils/JDBCUtils.java`:

```java
private static String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
private static String jdbcUsername = "todo_user";
private static String jdbcPassword = "todo_password";
```

**Note:** Replace with your Oracle database credentials:
- `localhost:1521` - Your Oracle host and port
- `XE` - Your Oracle SID or Service Name
- `todo_user` - Your database username
- `todo_password` - Your database password

### 3. Import Project into Eclipse

1. Open Eclipse IDE
2. Go to `File` → `Import` → `Existing Projects into Workspace`
3. Select the project root folder
4. Click `Finish`

### 4. Add Required Libraries

Ensure the following JAR files are present in `WebContent/WEB-INF/lib/`:
- `ojdbc8.jar` or `ojdbc11.jar` (Oracle JDBC Driver)
- `jstl-1.2.jar` (JSTL Library)
- `servlet-api-2.5.jar` (Servlet API)
- `jsp-api-2.2.jar` (JSP API)

If missing, download and add them to the lib folder.

### 5. Configure Tomcat Server in Eclipse

1. Go to `Window` → `Preferences` → `Server` → `Runtime Environments`
2. Click `Add` → Select `Apache Tomcat v8.5` or higher
3. Browse to your Tomcat installation directory
4. Click `Finish`

### 6. Deploy and Run

1. Right-click on the project
2. Select `Run As` → `Run on Server`
3. Choose your Tomcat server
4. Click `Finish`

The application will start on: **http://localhost:8080/todo-application/**

## 📱 Application Structure

```
todo-application/
│
├── src/
│   └── net/javaguides/todoapp/
│       ├── dao/                    # Data Access Layer
│       │   ├── LoginDao.java       # Login authentication logic
│       │   ├── TodoDao.java        # Todo interface
│       │   ├── TodoDaoImpl.java    # Todo CRUD operations
│       │   └── UserDao.java        # User registration logic
│       │
│       ├── model/                  # Model/Entity Classes
│       │   ├── LoginBean.java      # Login model
│       │   ├── Todo.java           # Todo entity
│       │   └── User.java           # User entity
│       │
│       ├── utils/                  # Utility Classes
│       │   └── JDBCUtils.java      # Database connection utility
│       │
│       └── web/                    # Controller Layer
│           ├── LoginController.java    # Login/Logout servlet
│           ├── TodoController.java     # Todo CRUD servlet
│           └── UserController.java     # User registration servlet
│
├── WebContent/
│   ├── common/                     # Reusable JSP components
│   │   ├── header.jsp              # Navigation header
│   │   └── footer.jsp              # Footer
│   │
│   ├── login/                      # Login pages
│   │   └── login.jsp               # Login form
│   │
│   ├── register/                   # Registration pages
│   │   └── register.jsp            # User registration form
│   │
│   ├── todo/                       # Todo pages
│   │   ├── todo-list.jsp           # Display all todos
│   │   └── todo-form.jsp           # Add/Edit todo form
│   │
│   ├── WEB-INF/
│   │   ├── lib/                    # JAR libraries
│   │   └── web.xml                 # Deployment descriptor
│   │
│   └── Error.jsp                   # Error page
│
├── script_oracle.sql               # Oracle database script
└── README.md                       # This file
```

## 🎯 Usage Guide

### 1. Register a New User
1. Navigate to the application URL
2. Click on **"Register"**
3. Fill in your details (First Name, Last Name, Username, Password)
4. Click **"Register"**

### 2. Login
1. Enter your **Username** and **Password**
2. Click **"Login"**

### 3. Add a Todo
1. After login, click **"Add Todo"**
2. Fill in:
   - **Title** - Short todo title
   - **Description** - Detailed description
   - **Target Date** - Deadline for the todo
3. Click **"Save"**

### 4. Edit a Todo
1. Click the **"Edit"** button next to any todo
2. Modify the fields
3. Click **"Save"**

### 5. Delete a Todo
1. Click the **"Delete"** button next to the todo
2. Confirm deletion

### 6. Mark as Complete
1. Check the **"Done"** checkbox when editing a todo
2. Click **"Save"**

## 🔐 Default Credentials

After setting up the database, you can use these credentials:

- **Username:** `admin`
- **Password:** `admin123`

Or register a new account from the registration page.

## 🐛 Troubleshooting

### Issue: ClassNotFoundException for Oracle Driver
**Solution:** Ensure `ojdbc8.jar` is in `WebContent/WEB-INF/lib/` and added to build path.

### Issue: SQLException - Connection Refused
**Solution:** 
- Verify Oracle Database is running
- Check connection details in `JDBCUtils.java`
- Ensure Oracle listener is started: `lsnrctl status`

### Issue: ORA-00942: table or view does not exist
**Solution:** Run the `script_oracle.sql` to create tables and sequences.

### Issue: Page not loading after login
**Solution:** Clear browser cache and check Tomcat logs for errors.

### Issue: Tomcat deployment errors
**Solution:** 
- Clean Tomcat work directory
- Rebuild the project
- Restart Tomcat server

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Future Enhancements

- [ ] Add password encryption (BCrypt)
- [ ] Implement todo categories/tags
- [ ] Add search and filter functionality
- [ ] User profile management
- [ ] Email notifications for due dates
- [ ] REST API endpoints
- [ ] Unit and integration tests
- [ ] Docker containerization
- [ ] Spring Boot migration

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Abhishek JC**

- GitHub: [@Abhishekjc19](https://github.com/Abhishekjc19)

## 🙏 Acknowledgments

- Inspired by Java EE best practices
- Bootstrap for responsive design
- Oracle Database for robust data management
- Java Guides community for tutorials

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Open an issue on GitHub
3. Contact the author

---

⭐ **Star this repository if you find it helpful!** ⭐

---

**Happy Coding! 🚀**
