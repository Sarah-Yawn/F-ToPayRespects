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
<html lang="en-us">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Make Changes</title>
		<link rel ="stylesheet" type="text/css" media="screen" href="css/screen.css">
		<style>
			form {width: 700px;
				margin-left:auto;
				margin-right:auto;
				}
			label {display: inline-block;
				width: 250px;
				padding: 10px;
				}
			label[for=message] {vertical-align: top;
								}
			input[type=text], input[type=tel],input[type=email], select, textarea {width: 250px;
							}
			input[type=submit] {width: 100px;
								cursor: pointer;
								margin-top: 25px;
								}
			textarea {margin-top: 10px;
					resize: none;
					rows: 250;
					columns: 400;
					}

			.center {
			  display: block;
			  margin-left: auto;
			  margin-right: auto;
			  width: 50%;
			}
		</style>
	</head>
	<body>
		<div id="page">
			<header>
				<a class="logo" title="Electric Motorcycles" href="#"><span>Electric Motorcycles</span></a>
				<!--<img src="images\ContactBanner.jpg" alt = "Contact page Banner" width = "500px" style="padding-top:120px; padding-left:50px;">-->
				<div class="hero">					
					<h1>Make Changes</h1>
				</div> <!--hero-->
			</header>
			<section class ="main">
				<h1 id="motorTitle" style="text-align:center">Make Changes</h1>
				<%
				try{
				connection = DriverManager.getConnection(connectionUrl+database, userid, password);
				statement=connection.createStatement();
				int motorcycleId = Integer.parseInt(request.getParameter("id"));
				String sql ="select * from incart where itemId = "+ motorcycleId;
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
					
					//set itemId of each item in table
					//int itemId = resultSet.getInt("itemId");
				%>
				<img alt="selected motorcycle" src=<%=image%> id="motorImage" class="center">
				<h2 id="totPrice" style="text-align:center">Total Price: <%=total%></h2>
<!--Change form action-->
				<form  method="post" action="ChangeInCart.jsp">
					<fieldset>
						<legend>Customize Your Motorcycle</legend>
						<!--itemId-->
						<input type="hidden" name="id" value ="<%=motorcycleId%>">
						<!--Model-->
						<label for="model">Model:</label>
						<select id="model" name="model" onchange="changeImage(), calcCost()" required>
							<%
								switch(resultSet.getString("model")){
								case "Fire Fly":
							%>
									<option value="1" selected>FireFly (24v $3,999)</option>
									<option value="2">Sparkle (48 $5,999)</option>
									<option value="3">Lightning (96v $8,999)</option>
									<option value="4">Thunder (192V $10,999)</option>
							<%		
									break;
								case "Sparkle":
							%>
									<option value="1">FireFly (24v $3,999)</option>
									<option value="2" selected>Sparkle (48 $5,999)</option>
									<option value="3">Lightning (96v $8,999)</option>
									<option value="4">Thunder (192V $10,999)</option>
							<%		
									break;
								case "Lightning":
							%>
									<option value="1">FireFly (24v $3,999)</option>
									<option value="2">Sparkle (48 $5,999)</option>
									<option value="3" selected>Lightning (96v $8,999)</option>
									<option value="4">Thunder (192V $10,999)</option>
							<%		
									break;
								case "Thunder":
							%>
									<option value="1">FireFly (24v $3,999)</option>
									<option value="2">Sparkle (48 $5,999)</option>
									<option value="3">Lightning (96v $8,999)</option>
									<option value="4" selected>Thunder (192V $10,999)</option>
							<%
									break;
							}
							%>
						</select><br>
						
						<!--Color-->
						<label for="color">Color:</label>
						<select id="color" name="color" onchange="enableGraphic(), calcCost()" required>
						<%	
							switch(resultSet.getString("color")){
								case "White":
						%>
									<option value="1" selected>white</option>
									<option value="2">black</option>
									<option value="3">Sonic Yellow (premium +$250)</option>
									<option value="4">Shocking Red (premium +$250)</option>
						<%			
									break;
								case "Black":
						%>
									<option value="1">white</option>
									<option value="2" selected>black</option>
									<option value="3">Sonic Yellow (premium +$250)</option>
									<option value="4">Shocking Red (premium +$250)</option>
						<%
									break;
								case "Sonic Yellow":
						%>
									<option value="1">white</option>
									<option value="2">black</option>
									<option value="3" selected>Sonic Yellow (premium +$250)</option>
									<option value="4">Shocking Red (premium +$250)</option>
						<%
									break;
								case "Shocking Red":
						%>
									<option value="1">white</option>
									<option value="2">black</option>
									<option value="3">Sonic Yellow (premium +$250)</option>
									<option value="4" selected>Shocking Red (premium +$250)</option>
						<%
									break;
							}
						%>
						</select><br>
						
						<!--Wheels-->
						<label for="wheels">Wheels:</label>
						<select id="wheels" name="wheels" onchange="calcCost()" required>
						<%
							if(resultSet.getString("wheel").equals("Premium")) {
						%>
								<option value="1">Standard</option>
								<option value="2" selected>Premium (+$100)</option>
						<%
							}
							else {
						%>
								<option value="1" selected>Standard</option>
								<option value="2">Premium (+$100)</option>
						<%	
							}
						%>
						</select><br>
						
						<!--Seat-->
						<label for="seat">Seat:</label>
						<select id="seat" name="seat" required>
						<%
							if(resultSet.getString("seat").equals("Standard")) {
						%>
							<option value="1" selected>Standard</option>
							<option value="2">Solo</option>
						<%
							}
							else {
						%>
							<option value="1">Standard</option>
							<option value="2" selected>Solo</option>
						<%
							}
						%>
						</select><br>
						
						<!--Graphic-->
						<label for="graphic">Performance Graphics <br>(premium color only):</label>
						<%
							if(resultSet.getInt("graphic") == 0) {
						%>
							<input type="checkbox" id="graphic" name="graphic" value="graphic" onChange="calcCost()"><br>
						<%
							}
							else {
						%>
							<input type="checkbox" id="graphic" name="graphic" value="graphic" onChange="calcCost()" checked><br>
						<%
							}
						%>
						
						<!--submit button-->
						<input type="submit" name="cart" value="Save Changes" style="margin-left: 275px;">
					</fieldset>
				</form>
			</section> <!--main-->
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
		
		<!--javascript-->
		<script>
			var box = document.getElementById("graphic");
			enableGraphic();
			//box.disabled = true;
			
			function enableGraphic() {
				var colnum = color.value;
				if(colnum === "3" || colnum === "4"){
					box.disabled = false;
				}
				else{
					box.checked = false;
					box.disabled = true;
				}
			}
			
			function changeImage() {
				var modnum = model.value;
				var image = document.getElementById('motorImage');
				var title = document.getElementById('motorTitle');
				switch (modnum) {
					case "1":
						if (!image.src.match("images/motorcycle1.png")) {
							image.src = "images/motorcycle1.png"
							title.innerHTML = "Fire Fly";
						}
						break;
					case "2":
						if (!image.src.match("images/motorcycle2.png")) {
							image.src = "images/motorcycle2.png"
							title.innerHTML = "Sparkle";
						}
						break;
					case "3":
						if (!image.src.match("images/motorcycle3.png")) {
							image.src = "images/motorcycle3.png"
							title.innerHTML = "Lightning";
						}
						break;
					case "4":
						if (!image.src.match("images/motorcycle4.png")) {
							image.src = "images/motorcycle4.png"
							title.innerHTML = "Thunder";
						}
						break;				
				}
			}
			
			function calcCost() {
				var modPrice = 0;
				var colPrice = 0;
				var wheelPrice = 0;
				var graphPrice = 0;
				var total;
				
				var modNum = document.getElementById('model').value;
				var colNum = document.getElementById('color').value;
				var wheelNum = document.getElementById('wheels').value;
				var graphCheck = document.getElementById('graphic').checked;
				//alert(modNum + colNum + wheelNum + graphCheck);
				
				//model
				switch(modNum){
					case '1':
						modPrice = 3999;
						break;
					case '2':
						modPrice = 5999;
						break;
					case '3':
						modPrice = 8999;
						break;
					case '4':
						modPrice = 10999;
						break;
				}
				
				//color
				if(colNum > 2){
					colPrice = 250;
				}
				else{
					colPrice = 0;
				}
				
				//wheels
				if(wheelNum == 2) {
					wheelPrice = 100;
				}
				else {
					wheelPrice = 0;
				}
				
				//graphic
				if(graphCheck){
					graphPrice = 350;
				}
				else{
					graphPrice = 0;
				}
				
				//total
				total = modPrice + colPrice + wheelPrice + graphPrice;
				var totTitle = document.getElementById('totPrice');
				totTitle.innerHTML =("Total Price: $" + Intl.NumberFormat().format(total));
			}
		</script>
	</body>
</html>