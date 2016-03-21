package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDAO {

	private static Connection con;

	public Connection getConnection() { 

		try { 
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=av1_lab_bd","sa","123456");
//			con = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=av1_lab_bd;namedPipe=true","av1","123");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
			return con; 
		}


	public void fechaConexao(){
		try {
			if(con!=null) con.close();
			con =null;
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}