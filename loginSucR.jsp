<HTML>
<HEAD>
<TITLE>Login Page</TITLE>
<link rel="stylesheet" href="css/style.css" type="text/css">
<a href="login.html" style="float: right;">Log out</a>
</HEAD>

<a href="help.html">HELP</a>

<script language = "javascript">
<!--

function checkEmpty(){
	if(EditForm.firstNa.value ==""){
		window.alert("First name can not be empty");
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



function checkNewRole(){
	if(RadForm.Role.value==("r")){
		return true;
	}else{
		window.alert("you can not upload pic");
		return false;
		}
}
-->
</script>
<BODY><CENTER>
<!--This is the login page-->
<H1 bgcolor=#0000ff><CENTER>Welcome Radiologist</CENTER></H1>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<%@ page import="java.sql.*" %>
<%
//This page is for radiologiest login success
    String userName=null;
	String role=null;
	int id=0;
	if(request.getParameter("user") != null){
		userName = (request.getParameter("user")).trim();
		out.println("<p>Account Information</p>");
		out.println("Welcome " +userName );
		
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
	
			String userIDName="";
        	Statement stmt = null;
	     

	        
			
        	//get personID
			String sqll ="select person_id,user_name from users where user_name = '"+userName+"'";
	        ResultSet rsett = null;
	        try{
	        	stmt = conn.createStatement();
		        rsett = stmt.executeQuery(sqll);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	        
        	if(rsett.next()){
        		id= Integer.parseInt(rsett.getString(1));
        		userIDName=rsett.getString(2);
        	}
        	//get personal information from person table to let them modify
        	try{
		        rsett = stmt.executeQuery("select p.first_name, p.last_name, p.address,p.email,p.phone, u.password, u.class from persons p, users u where p.person_id = "+id+" and u.person_id = "+id+"");
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
        	%>
			<left>
        		<table class = "zebra" border="2">
	    		<caption>Your Information</caption>
			<tr><td>First Name</td><td>Last Name</td><td>Password</td><td>Class</td><td>Address</td><td>Email</td><td>Phone</td></tr>
			
			<%
			if(rsett.next()){
        		%>
        		<tr><td><%=rsett.getString(1)%></td><td><%=rsett.getString(2)%></td><td><%=rsett.getString(6)%>
        		</td><td><%=rsett.getString(7)%></td><td><%=rsett.getString(3)%></td><td>
        		<%=rsett.getString(4)%></td><td><%=rsett.getString(5)%></td></tr>
        		<% 
        		role=rsett.getString(7);
        	}
        	
        	%>
			</table>
			
			<P>You can edit your information below</P>
			<%
			out.println("User Name: " + userName );
			
			 try{
                 conn.close();
         }
         catch(Exception ex){
                 out.println("<hr>" + ex.getMessage() + "<hr>");
             
         }
	} 
%>

<FORM NAME="EditForm" ACTION="update.jsp"+userName METHOD="post" >
<%
	out.println("<input TYPE ='hidden' name='userNN' value ='"+userName+"' >");
	out.println("<input TYPE ='hidden' name='Role' value ='"+role+"' >");
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


</FORM>


<FORM NAME="RadForm" ACTION="upload.jsp" METHOD="post" >
<%
	out.println("<input TYPE ='hidden' name='Role' value ='"+role+"' >");
	out.println("<input TYPE ='hidden' name='userNN' value ='"+userName+"' >");
%>
<tr><th>RecordID: </th>
  <td><SELECT NAME="recordBB">
  <%
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
  	String sql ="select p.first_name, r.record_id from persons p, radiology_record r where r.patient_id = p.person_id";
  	Statement stmt = null;
  	ResultSet rsett = null;
  	try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sql);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
  	String patient_id="";
  	while(rsett.next()){
  		patient_id = rsett.getString(2);
  		String printt=rsett.getString(1)+":"+rsett.getString(2);
  	
  %>
		<Option value=<% out.println(patient_id);%>><%out.println(printt); %></Option>
<%
  	}
%>
</SELECT>
</td>
  </tr>

<INPUT TYPE="submit"NAME="Reset" VALUE="UploadPic" ONCLICK="return checkNewRole();">

</FORM>
<FORM NAME="RadUpForm" ACTION="uploadRad.jsp?radID"+id METHOD="post" >
<%
	out.println("<input TYPE ='hidden' name='Role' value ='"+id+"' >");
	out.println("<input TYPE ='hidden' name='userNN' value ='"+userName+"' >");
%>

<INPUT TYPE="submit"NAME="Reset" VALUE="UploadInfo" >

</FORM>

</FORM>
<FORM NAME="DocForm" ACTION="search_radi.jsp"+userName METHOD="post">

<INPUT TYPE="submit" NAME="Submit" VALUE="Search">
</FORM>
</CENTER>
</BODY>
</HTML>
