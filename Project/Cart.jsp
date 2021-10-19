<%@page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
//name of database to connect to
String database = "motorcycle";
//mysql userid
String userid = "root";
//mysql password
String password = "Ackley1869";
//Load database driver
try {
	Class.forName(driver);
	System.out.println("Driver loaded");
}
catch (Exception ex) {
	System.err.println("Driver error: " + ex);
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Cart</title>
		<link rel ="stylesheet" type="text/css" media="screen" href="css/screen.css">
	</head>
	<style>
		.item{
			height: 200px;
			width: 75%;
			background-color: #c9c9c9;
			margin-left: auto;
			margin-right: auto;
			margin-bottom: 25px;
		}
		table{
			float: right;
		}
	</style>
<body>
<div id="page">
	<header>
		<a class="logo" title="Electric Motorcycles" href="#"><span>Electric Motorcycles</span></a>
		<!--<img src="images\ContactBanner.jpg" alt = "Contact page Banner" width = "500px" style="padding-top:120px; padding-left:50px;">-->
		<div class="hero">
			<h1>Cart</h1>
		</div> <!--hero-->
	</header>
	<h1 style="text-align:center">Items in Your Cart</h1>
	<%
	try{
	connection = DriverManager.getConnection(connectionUrl+database, userid, password);
	statement=connection.createStatement();
	String sql ="select * from incart where orderId = 1";
	resultSet = statement.executeQuery(sql);
	String image = "";
	String graphicYN = "";
	while(resultSet.next()){
		//get image for item
		switch(resultSet.getString("model")){
			case "Fire Fly":
				image = "images/motorcycle1.png";
				break;
			case "Sparkle":
				image = "images/motorcycle2.png";
				break;
			case "Lightning":
				image = "images/motorcycle3.png";
				break;
			case "Thunder":
				image = "images/motorcycle4.png";
				break;				
		}
		//get graphic yes/no for item
		if(resultSet.getInt("graphic") == 0){
			graphicYN = "No";
		}
		else{
			graphicYN = "Yes";
		}
		//calc total cost of item
		//this won't be needed if total was stored in inCart table
		int modPrice = 0;
		int colPrice = 0;
		int wheelPrice = 0;
		int graphPrice = 0;
		int total;
		DecimalFormat money = new DecimalFormat("$#,##0");
		
		//model
		switch(resultSet.getString("model")){
			case "Fire Fly":
				modPrice = 3999;
				break;
			case "Sparkle":
				modPrice = 5999;
				break;
			case "Lightning":
				modPrice = 8999;
				break;
			case "Thunder":
				modPrice = 10999;
				break;
		}
		
		//color
		if(resultSet.getString("color").equals("Sonic Yellow") || resultSet.getString("color").equals("Shocking Red")){
			colPrice = 250;
		}
		else{
			colPrice = 0;
		}
		
		//wheel
		if(resultSet.getString("wheel").equals("Premium")) {
			wheelPrice = 100;
		}
		else {
			wheelPrice = 0;
		}
		
		//graphic
		if(resultSet.getInt("graphic") == 1){
			graphPrice = 350;
		}
		else{
			graphPrice = 0;
		}
		
		//total
		total = modPrice + colPrice + wheelPrice + graphPrice;
		
	%>
	<!--Each item in the cart -->
	<div class="item">
		<img alt="selected motorcycle" src="<%=image%>" height="180" width="300" style="margin: 10px;">
		<table>
			<tr>
				<td>Model: <%=resultSet.getString("model")%></td>
				<td>Color: <%=resultSet.getString("color")%></td>
				<td>Wheels: <%=resultSet.getString("wheel")%></td>
			</tr>
			<tr>
				<td>Seat: <%=resultSet.getString("seat")%></td>
				<td>Graphic: <%=graphicYN%></td>
				<td>total cost: <%=money.format(total)%></td>
			</tr>
		</table>
	</div> <!--item-->
	<!--notes to remember names of each thing in table-->
	<%--resultSet.getInt("itemId") --%>
	<%--resultSet.getInt("orderId") --%>
	<%--resultSet.getString("model") --%>
	<%--resultSet.getDouble("modelPrice") --%>
	<%--resultSet.getString("battery") --%>
	<%--resultSet.getString("color") --%>
	<%--resultSet.getDouble("colorPrice") --%>
	<%--resultSet.getString("wheel") --%>
	<%--resultSet.getDouble("wheelPrice") --%>
	<%--resultSet.getString("seat") --%>
	<%--resultSet.getDouble("seatCost") --%>
	<%--resultSet.getInt("graphic") --%>
	<%--resultSet.getDouble("graphicPrice") --%>
	<%
	}
	connection.close();
	}
	catch(Exception e) {
		System.out.println("SQL error during SELECT");
		System.out.println(e.getStackTrace());
		out.print("Didn't work");
	}
	%>
	<nav>
		<ul>
			<li>
				<a title="Home" href="HomePage.html" >Home</a>
			</li>
			<li>
				<a title="About Us" href="about.html" >About Us</a>
			</li>
			<li>
				<a title="Store" href="Store.html">Store</a>
			</li>
			<li>
				<a title="FAQ" href="FAQ.html" >FAQ</a>
			</li>
			<li>
				<a title="Contact Us" href="Contacts.html" >Contact Us</a>
			</li>
		</ul>
	</nav>

	<footer>
		&copy; Motorcycles
		<div class="content">
			<a title="Privacy Policy" href="#">Privacy Policy</a>
			<a title="Terms of Service" href="#">Terms of Service</a>
		</div> <!--content-->
	</footer>
</div> <!--page-->
</body>
</html>