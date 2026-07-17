package net.javaguides.todoapp.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;

public class JDBCUtils {

	// Oracle Database Configuration
	// Update these values according to your Oracle setup:
	// - localhost:1521 - Your Oracle host and port
	// - XE - Your Oracle SID (or use Service Name format)
	// - todo_user - Your database username
	// - todo_password - Your database password
	private static String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
	private static String jdbcUsername = "todo_user";
	private static String jdbcPassword = "todo_password";

	public static Connection getConnection() {
		Connection connection = null;
		try {
			// Oracle JDBC Driver
			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// Handle SQL exceptions
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// Handle driver class not found
			e.printStackTrace();
		}
		return connection;
	}

	public static void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}

	public static Date getSQLDate(LocalDate date) {
		return java.sql.Date.valueOf(date);
	}

	public static LocalDate getUtilDate(Date sqlDate) {
		return sqlDate.toLocalDate();
	}
}
