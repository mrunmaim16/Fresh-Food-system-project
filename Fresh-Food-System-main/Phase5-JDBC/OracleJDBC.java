import java.sql.*;
//or you can keep the following instead
//import java.sql.DriverManager;
//import java.sql.Connection;
//import java.sql.SQLException;
 
public class OracleJDBC {
 
	public static void main(String[] argv) {
 
		System.out.println("-------- Oracle JDBC Connection Testing ------");
 
		try {
 
			Class.forName("oracle.jdbc.driver.OracleDriver");
 
		} catch (ClassNotFoundException e) {
 
			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();
			return;
 
		}
 
		System.out.println("Oracle JDBC Driver Registered!");
 
		Connection connection = null;
 
		try {
 
 //below include your login and your password
            connection = DriverManager.getConnection("jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu", "<sqlplus-username>", "<sqlplus-password>");
		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
 
		}
 
		if (connection != null) {
			System.out.println("You made it, take control of your database now!\n");
            System.out.println("Printing employee names from the sharmac.employee table stored on omega");
		} else {
			System.out.println("Failed to make connection!");
		}
        try {
            Statement stmt = connection.createStatement();
	       ResultSet rs = stmt.executeQuery("select * from sharmac.employee");
	       while (rs.next())
	         System.out.println(rs.getString("fname")+" "+rs.getString("lname"));
	       rs.close();
	       stmt.close();
            connection.close();
        }
        catch (SQLException e) {
 
			System.out.println("erro in accessing the relation");
			e.printStackTrace();
			return;
 
		}    
	}
 
}
