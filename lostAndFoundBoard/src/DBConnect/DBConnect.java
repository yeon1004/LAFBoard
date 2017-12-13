package DBConnect;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	public DBConnect(){};
	
	public Connection getConnection() {
		Connection conn = null;
		
		String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
		String jdbc_url = "jdbc:oracle:thin:@127.0.0.1:1521:MyOracle";
		String id = "orauser";
		String pw = "dbpass";
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
