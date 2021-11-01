<%@page import="java.sql.*"%>

<html>
	<head>
		<title>New Item</title>
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
			//THIS NEEDS UPDATE SO THAT ORDER ID IS GENERATED FOR ORDER AND REUSED FOR EACH ITEM IN THAT ORDER.
			private static boolean changeRow(String model, double modelPrice, String battery, String color, double colorPrice, String wheel, double wheelPrice, String seat, double seatPrice, int graphic, double graphicPrice, int motorcycleId) {
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
					//THIS NEEDS UPDATE SO THAT ORDER ID IS GENERATED FOR ORDER AND REUSED FOR EACH ITEM IN THAT ORDER.
					ps = conn.prepareStatement("UPDATE inCart SET orderId = ?, model = ?, modelPrice = ?, battery = ?, color = ?, colorPrice = ?, wheel = ?, wheelPrice = ?, seat = ?, seatCost = ?, graphic = ?, graphicPrice = ? WHERE itemId = ?");
					ps.setInt(1, 1);
					ps.setString(2, model);
					ps.setDouble(3, modelPrice);
					ps.setString(4, battery);
					ps.setString(5, color);
					ps.setDouble(6, colorPrice);
					ps.setString(7, wheel);
					ps.setDouble(8, wheelPrice);
					ps.setString(9, seat);
					ps.setDouble(10, seatPrice);
					ps.setInt(11, graphic);
					ps.setDouble(12, graphicPrice);
					ps.setInt(13, motorcycleId);
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
				String model = request.getParameter("model");
				String color = request.getParameter("color");
				String wheels = request.getParameter("wheels");
				String seat = request.getParameter("seat");
				int graphic = 0;
				int motorcycleId = Integer.parseInt(request.getParameter("id"));
				
				double modelPrice = 0;
				double colorPrice = 0;
				double wheelPrice = 0;
				double seatPrice = 0;
				double graphicPrice = 0;
				
				String modelStr = "";
				String batteryStr = "";
				String colorStr = "";
				String wheelStr = "";
				String seatStr = "";
				
				if (request.getParameter("graphic") == null){
					graphic = 0;
				}
				else {
					graphic = 1;
				}
				
				switch(model){
					case "1":
						modelStr = "Fire Fly";
						modelPrice = 3999;
						batteryStr = "24v";
						break;
					case "2":
						modelStr = "Sparkle";
						modelPrice = 5999;
						batteryStr = "48v";
						break;
					case "3":
						modelStr = "Lightning";
						modelPrice = 8999;
						batteryStr = "96v";
						break;
					case "4":
						modelStr = "Thunder";
						modelPrice = 10999;
						batteryStr = "192v";
						break;
				}
				
				switch(color){
					case "1":
						colorStr = "White";
						colorPrice = 0;
						break;
					case "2":
						colorStr = "Black";
						colorPrice = 0;
						break;
					case "3":
						colorStr = "Sonic Yellow";
						colorPrice = 250;
						break;
					case "4":
						colorStr = "Shocking Red";
						colorPrice = 250;
						break;
				}
				
				if(Integer.parseInt(wheels) == 2) {
					wheelStr = "Premium";
					wheelPrice = 100;
				}
				else {
					wheelStr = "Standard";
					wheelPrice = 0;
				}
				
				if(Integer.parseInt(seat) == 2) {
					seatStr = "Solo";
				}
				else {
					seatStr = "Standard";
				}
				
				if(graphic == 1){
					graphicPrice = 350;
				}
				else{
					graphicPrice = 0;
				}
				/* Test values
				out.print("graphic: " + graphic);
				out.println("Model Price: " + modelPrice);
				out.println("color Price: " + colorPrice);
				out.println("Wheel Price: " + wheelPrice);
				out.println("Graphic Price: " + graphicPrice);
				out.println("seat Price: " + seatPrice);
				*/
				
				loadDriver();
				if(changeRow(modelStr, modelPrice, batteryStr, colorStr, colorPrice, wheelStr, wheelPrice, seatStr, seatPrice, graphic, graphicPrice, motorcycleId)) {
					out.print("Row inserted successfully.");
					out.print("<hr>");
					out.print("<h2>Motorcycle Info:</h2>");
					out.print("graphic: " + graphic);
					out.println("<br>Model Price: " + modelPrice);
					out.println("<br>color Price: " + colorPrice);
					out.println("<br>Wheel Price: " + wheelPrice);
					out.println("<br>Graphic Price: " + graphicPrice);
					out.println("<br>seat Price: " + seatPrice);
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
		<a href="Cart.jsp">Go Back To Cart</a>
	</body>
</html>