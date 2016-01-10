<HTML>
<HEAD>
<TITLE>Login Page</TITLE>
<link rel="stylesheet" href="css/style.css" type="text/css">
<a href="help.html" >HELP</a>
</HEAD>
<script language = "javascript">
<!--

function checkEmpty(){
	if(EditForm.firstNa.value ==""){
		window.alert("First name can not be empty");
		return false;
	}
	else if(EditForm.UserID.value == ""){
		window.alert("user id can not be empty");
		return false;
		}	
	else if(EditForm.lastNa.value ==""){
		window.alert("Last Name can not be empty");
		return false;
	}	
	else if(EditForm.PASSWD.value ==""){
		window.alert("Password can not be empty");
		return false;
	}
	else if(EditForm.PASSWD.value !=EditForm.PASSWD2.value){
		window.alert("Password doesn't match can not be empty");
		return false;
	}
	else if(EditForm.Address.value ==""){
		window.alert("Address can not be empty");
		return false;
	}
	else if(EditForm.Email.value ==""){
		window.alert("Email can not be empty");
		return false;
	}
	else if(EditForm.Phone.value ==""){
		window.alert("Phone can not be empty");
		return false;
	}
}



-->
</script>
<BODY><CENTER>
<!--This is the login page-->
<H1 bgcolor=#0000ff><CENTER>User Information</CENTER></H1>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<%@ page import="java.sql.*" %>
<%
//people can choose regeste new 
	if(request.getParameter("UserID") != null){
		String userName = (request.getParameter("UserID")).trim();
		String firstNa = request.getParameter("firstNa");
		String lastNa = request.getParameter("lastNa");
		String password = request.getParameter("PASSWD");
		String address = request.getParameter("Address");
		String email = request.getParameter("Email");
		String phone = request.getParameter("Phone");
		String classtype = request.getParameter("Class");
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
	
	        //select the user table from the underlying db and validate the user name and password
	     

	        
			
        	//get personID
			String sqll ="select count(*) from users where user_name = '"+userName+"'";
			Statement stmt = null;
	        ResultSet rsett = null;
	        try{
	        	stmt = conn.createStatement();
		        rsett = stmt.executeQuery(sqll);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	        int amount=0;
        	if(rsett.next()){
        		amount= Integer.parseInt(rsett.getString(1));
        	}
        	if(amount !=0){
        		out.println("<hr>" + "UserID already exist" + "<hr>");
        		
        	}else{
        		try{
    	        	stmt = conn.createStatement();
    		        rsett = stmt.executeQuery("select max(person_id) from persons");
            	}
    	
    	        catch(Exception ex){
    		        out.println("<hr>" + ex.getMessage() + "<hr>");
            	}
        		int id =0;
        		if(rsett.next()){
        			id= Integer.parseInt(rsett.getString(1));
        		}

        		id=id+1;
        		String sqls="insert  into persons values ('"+id+"','"+firstNa+"', '"+lastNa+"','"+address+"','"+email+"', '"+phone+"')";
        	    String sqlu="insert into users values('"+userName+"','"+password+"' ,'"+classtype+"','"+id+"',sysdate)";
        	    try{
        	    	stmt = conn.createStatement();
        	        rsett = stmt.executeQuery(sqls);
        	        rsett = stmt.executeQuery(sqlu);
        	        stmt.executeUpdate("commit");
        		}

        	    catch(Exception ex){
        	        out.println("<hr>" + ex.getMessage() + "<hr>");
        		}
        	    //after success, jump back to login page
        	    response.sendRedirect("login.html");
        	}
        	
        	//get information from person table
        	
        	
        	
		try{
                        conn.close();
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
	}else{
		
	}
%>

<FORM NAME="EditForm" ACTION="regester.jsp"+userName METHOD="post" >

<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>UserID:</I></B></TD>
<TD><INPUT TYPE="text" NAME="UserID" VALUE=""></TD>
</TR>
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
<TD><B><I>Class:</I></B></TD>
<TD><SELECT NAME="Class">
<Option value='p'>patient</Option>
<Option value='d'>doctor</Option>
<Option value='r'>radiologist</Option>
</TD>
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


</FORM>

</CENTER>
</BODY>
</HTML>
