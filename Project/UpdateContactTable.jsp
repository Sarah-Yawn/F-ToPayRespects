<%@page import="java.sql.*"%>

<html>
	<head>
		<title>New Contact</title>
	</head>
	<body>
		<%!
			//Load database driver
			private static void loadDriver() {	    	
				try {			
					Class.forName("com.mysql.cj.jdbc.Driver");
					System.out.println("Driver loaded");			
				}
				catch (Exception ex) {
					System.err.println("Driver error: " + ex);
				}        
			}
			//end of loadDriver method
			
			//insert a row with entered values
			private static boolean insertRow(String fName, String lName, String phoneNum, String email, String subjectLine, String content) {
				//create database connection
				Connection conn = null;
				try {
					String userName = "root";
					String password = "Ackley1869";
					String url = "jdbc:mysql://localhost:3306/motorcycle";			
					conn = DriverManager.getConnection (url, userName, password);
					System.out.println ("Database connection established");
				}
				catch(Exception e) {
					System.err.println ("Cannot connect to database");
					System.err.println(e.getMessage());
					return false;
				}
				
				//create insert statement using the PreparedStatement object
				try {
					int count;
					PreparedStatement ps;
					ps = conn.prepareStatement("INSERT INTO contact (fName, lName, phoneNum, email, subjectLine, content) VALUES(?,?,?,?,?,?)");
					ps.setString(1, fName);
					ps.setString(2, lName);
					ps.setString(3, phoneNum);
					ps.setString(4, email);
					ps.setString(5, subjectLine);
					ps.setString(6, content);
					System.out.println("Row added: " + ps.toString());
					count = ps.executeUpdate();
					ps.close();
				}
				catch(Exception e) {
					System.out.println("SQL error during INSERT");
					System.out.println(e.getStackTrace());
					return false;
				}
				
				return true;
				
			}
			//end of insertRow method
		%>
		Database response:
		<br>
		<!-- call jsp methods-->
		<%
			try {
				String fName = request.getParameter("fName");
				String lName = request.getParameter("lName");
				String phoneNum = request.getParameter("phoneNum");
				String email = request.getParameter("email");
				String subjectLine = request.getParameter("subjectLine");
				String content = request.getParameter("content");
				
				loadDriver();
				if(insertRow(fName, lName, phoneNum, email, subjectLine, content)) {
					out.print("Row inserted successfully.");
					out.print("<hr>");
					out.print("<h2>contact Info:</h2>");
					out.print("first name: " + fName + "<br>last name: " + lName + "<br>phone number: " + phoneNum + "<br>email: " + email  + "<br>content: " + content);
				}
				else {
					out.print("Error! Row not inserted.");
				}
			}
			catch(Exception e) {
				out.print("input error");
			}
		%>
		<hr>
		<a href="Contacts.html">Go Back</a>
	</body>
</html>