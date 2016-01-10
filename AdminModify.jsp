<HTML>
<HEAD>
<TITLE>Login Page</TITLE>
</HEAD>
<link rel="stylesheet" href="css/style.css" type="text/css">
<a href="help.html">HELP</a>
<H1><Center>Management Page</Center></H1>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<script language = "javascript">
<!--

function checkEmpty(){
	if(EditForm2.firstNa.value ==""){
		window.alert("First name can not be empty");
		return false;
	}	
	else if(EditForm2.lastNa.value ==""){
		window.alert("Last Name can not be empty");
		return false;
	}	
	else if(EditForm2.PASSWD.value ==""){
		window.alert("Password can not be empty");
		return false;
	}
	else if(EditForm2.PASSWD.value !=EditForm.PASSWD2.value){
		window.alert("Password doesn't match can not be empty");
		return false;
	}
	else if(EditForm2.Address.value ==""){
		window.alert("Address can not be empty");
		return false;
	}
	else if(EditForm2.Email.value ==""){
		window.alert("Email can not be empty");
		return false;
	}
	else if(EditForm2.Phone.value ==""){
		window.alert("Phone can not be empty");
		return false;
	}
}



-->
</script>
<BODY>
<%@ page import="java.sql.*" %>
	<%
	//administrator can modify everyone's information on this page 
	int id=0;
	if(request.getParameter("ID") != null){
		 id = Integer.parseInt(request.getParameter("ID"));

		Connection conn = null;
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
	        ResultSet rsett = null;
	        String sql="select * from users where person_id = '"+id+"'";
	        try{
	        	stmt = conn.createStatement();
	            rsett = stmt.executeQuery(sql);
	         
	    	}

	        catch(Exception ex){
	            out.println("<hr>" + ex.getMessage() + "<hr>");
	    	}
	        if(rsett.next()){
				if(request.getParameter("firstNa") != null){
			
			String firstNa = request.getParameter("firstNa");
			String lastNa = request.getParameter("lastNa");
			String password = request.getParameter("PASSWD");
			String address = request.getParameter("Address");
			String email = request.getParameter("Email");
			String phone = request.getParameter("Phone");
			String classtype = request.getParameter("Class");
			
			
			
		    
		       //update the new information
		        
		        String sqls="UPDATE persons SET first_name ='"+firstNa+"', last_name ='"+lastNa+"',address = '"+address+"', email = '"+email+"', phone = '"+phone+"' WHERE person_id = '"+id+"'";
		        String sqlu="UPDATE users SET  password ='"+password+"' WHERE person_id = '"+id+"'";
		        try{
		        	stmt = conn.createStatement();
		            rsett = stmt.executeQuery(sqls);
		            rsett = stmt.executeQuery(sqlu);
		            stmt.executeUpdate("commit");
		    	}

		        catch(Exception ex){
		            out.println("<hr>" + ex.getMessage() + "<hr>");
		    	}
		        
		        try{
		            conn.close();
		    	}
		    	catch(Exception ex){
		            out.println("<hr>" + ex.getMessage() + "<hr>");
		    }
		        response.sendRedirect("adminManag.jsp");
			out.println("lol");
			 
			}%>
    		<FORM NAME="EditForm2" ACTION="AdminModify.jsp"+userName METHOD="post" ><center>
    		<%
    			out.println("<input TYPE ='hidden' name='ID' value ='"+id+"' >");
    		%>
    		<TABLE>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>FirstName:</I></B></TD>
    		<TD><INPUT TYPE="text" NAME="firstNa" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>LastName:</I></B></TD>
    		<TD><INPUT TYPE="text" NAME="lastNa" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>Password:</I></B></TD>
    		<TD><INPUT TYPE="password" NAME="PASSWD" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>Re-Password:</I></B></TD>
    		<TD><INPUT TYPE="password" NAME="PASSWD2" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>Address:</I></B></TD>
    		<TD><INPUT TYPE="text" NAME="Address" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>Email:</I></B></TD>
    		<TD><INPUT TYPE="text" NAME="Email" VALUE=""></TD>
    		</TR>
    		<TR VALIGN=TOP ALIGN=LEFT>
    		<TD><B><I>Phone:</I></B></TD>
    		<TD><INPUT TYPE="text" NAME="Phone" VALUE=""></TD>
    		</TR>
    		</TABLE>

    		<INPUT TYPE="submit" NAME="Submit" VALUE="Edit" ONCLICK ="return checkEmpty();">

    		</center>
    		</FORM><% 
	        }else{
	        	out.println("no such an id");
	        	%>
	        	<a href ="adminManag.jsp">Return</a>
	        	<% 
	        }
	        	
	        
	}else{
	}
	
	%>
	
	



</BODY>
</HTML>
