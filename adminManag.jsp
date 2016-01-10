<HTML>
<HEAD>
<a href="login.html" style="float: right;">Log out</a>
<a href="help.html" >HELP</a>
<TITLE><Center>User Management Page</Center></TITLE>
</HEAD>
<link rel="stylesheet" href="css/style.css" type="text/css">
<script language = "javascript">
<!--

function checkID(){
	if(AdminForm.ID.value ==""){
		window.alert("can not be empty");
		return false;
	}	
	
	
	
}

-->
</script>
<body><CENTER><H1 bgcolor=#0000ff>User Management Page</H1>
	<H2>User Account Table</H2>
	<%@ page import="java.sql.*" %>
	<%
		//administrator can see all informations from users and modify
		Connection conn = null;
		int count=0;
		int userIDUse;
	    String driverName = "oracle.jdbc.driver.OracleDriver";
	    String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	        try{
		        //load and register the driver
	    		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
	    	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");

	        }

	    	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"cye2","Jeff1992");
	    		conn.setAutoCommit(false);
	        }
	    	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	    	}
	    	Statement stmt = null;
	    	String sqll ="select count(*) from users";
	        ResultSet rsett = null;
	        try{
	        	stmt = conn.createStatement();
		        rsett = stmt.executeQuery(sqll);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	      
        	if(rsett.next()){
        		count= Integer.parseInt(rsett.getString(1));
        		out.println(count+"count");
        	}
	        //get all informations for each user
	        try{
	        	rsett = stmt.executeQuery("select p.first_name, p.last_name, p.address,p.email,p.phone, u.password, u.class ,p.person_id from persons p, users u where p.person_id =u.person_id");
	        }catch(Exception ex){
	            out.println("<hr>" + ex.getMessage() + "1<hr>");
	    	}
	        %>
			<table border="2">
			<tr><td>ID</td><td>First Name</td><td>Last Name</td><td>Password</td><td>Class</td><td>Address</td><td>Email</td><td>Phone</td></tr>
			
			<%
			while(rsett.next()){
        		%>
        		<tr><td><%=rsett.getInt(8)%></td><td><%=rsett.getString(1)%></td><td><%=rsett.getString(2)%></td><td><%=rsett.getString(6)%>
        		</td><td><%=rsett.getString(7)%></td><td><%=rsett.getString(3)%></td><td>
        		<%=rsett.getString(4)%></td><td><%=rsett.getString(5)%></td></tr>
        		<% 
        	}
        	
        	%>
			</table>
<BR><BR><BR><BR><BR>
<FORM NAME="AdminForm" ACTION="AdminModify.jsp" METHOD="post" >
<%
	out.println("<input TYPE ='hidden' name='total' value ='"+count+"' >");
%>
<TD><B><I>Input ID:</I></B></TD>
<INPUT TYPE="text" NAME="ID" VALUE="" ">

<INPUT TYPE="submit" NAME="Reset" VALUE="Managnment" ONCLICK="return checkID();" ">

</FORM>
<FORM NAME="reportForm" ACTION="report.jsp" METHOD="post" >

<INPUT TYPE="submit"NAME="Reset" VALUE="Report" ">

</FORM>
</Center>
</BODY>
</HTML>
