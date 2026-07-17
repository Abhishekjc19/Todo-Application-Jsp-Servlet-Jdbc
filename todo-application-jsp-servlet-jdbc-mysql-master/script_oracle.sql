-- ========================================
-- Oracle SQL Script for Todo Application
-- ========================================
-- This script creates the required tables and sequences for the Todo Application
-- Run this script as your database user (e.g., todo_user)

-- Drop existing tables and sequences if they exist (for clean setup)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE todos CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE users_seq';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE todos_seq';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- ========================================
-- Create Users Table
-- ========================================
CREATE TABLE users (
    id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    username VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(50) NOT NULL
);

-- Create sequence for users table (auto-increment)
CREATE SEQUENCE users_seq 
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE 
    NOCYCLE;

-- Create trigger for auto-increment on users table
CREATE OR REPLACE TRIGGER users_bir 
BEFORE INSERT ON users 
FOR EACH ROW
BEGIN
    IF :new.id IS NULL THEN
        SELECT users_seq.NEXTVAL INTO :new.id FROM dual;
    END IF;
END;
/

-- ========================================
-- Create Todos Table
-- ========================================
CREATE TABLE todos (
    id NUMBER(19) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    username VARCHAR2(100) NOT NULL,
    description VARCHAR2(500),
    target_date DATE,
    is_done NUMBER(1) DEFAULT 0 CHECK (is_done IN (0, 1))
);

-- Create sequence for todos table (auto-increment)
CREATE SEQUENCE todos_seq 
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE 
    NOCYCLE;

-- Create trigger for auto-increment on todos table
CREATE OR REPLACE TRIGGER todos_bir 
BEFORE INSERT ON todos 
FOR EACH ROW
BEGIN
    IF :new.id IS NULL THEN
        SELECT todos_seq.NEXTVAL INTO :new.id FROM dual;
    END IF;
END;
/

-- ========================================
-- Create Indexes for Performance
-- ========================================
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_todos_username ON todos(username);
CREATE INDEX idx_todos_target_date ON todos(target_date);

-- ========================================
-- Insert Sample Data
-- ========================================
-- Insert a default admin user (password: admin123)
INSERT INTO users (id, first_name, last_name, username, password) 
VALUES (users_seq.NEXTVAL, 'Admin', 'User', 'admin', 'admin123');

-- Insert sample todos
INSERT INTO todos (id, title, username, description, target_date, is_done) 
VALUES (todos_seq.NEXTVAL, 'Welcome Todo', 'admin', 'This is your first todo item. Edit or delete it to get started!', SYSDATE + 7, 0);

INSERT INTO todos (id, title, username, description, target_date, is_done) 
VALUES (todos_seq.NEXTVAL, 'Learn Oracle SQL', 'admin', 'Study Oracle SQL fundamentals and advanced features', SYSDATE + 14, 0);

-- Commit the changes
COMMIT;

-- ========================================
-- Verify Installation
-- ========================================
-- Display row counts
SELECT 'Users table created with ' || COUNT(*) || ' records' AS status FROM users;
SELECT 'Todos table created with ' || COUNT(*) || ' records' AS status FROM todos;

-- Display all users
SELECT 'User List:' AS info FROM dual;
SELECT id, first_name, last_name, username FROM users;

-- Display all todos
SELECT 'Todo List:' AS info FROM dual;
SELECT id, title, username, target_date, is_done FROM todos;

PROMPT
PROMPT ========================================
PROMPT Database setup completed successfully!
PROMPT ========================================
PROMPT Default Login Credentials:
PROMPT Username: admin
PROMPT Password: admin123
PROMPT ========================================
