<HTML>
<HEAD>
<TITLE>Login Page</TITLE>
  <link rel="stylesheet" href="css/style.css" type="text/css">
<a href="help.html" >HELP</a>
</HEAD>
<body>
<%@ page import="java.sql.*" %>
<%
//usrs can update their personal informations from here
if(request.getParameter("firstNa") != null && request.getParameter("firstNa")!=null)
{
	String userId= request.getParameter("userNN");
	String userType=request.getParameter("Role");
	//out.println(userID+"");
	String firstNa = request.getParameter("firstNa");
	String lastNa = request.getParameter("lastNa");
	String password = request.getParameter("PASSWD");
	String address = request.getParameter("Address");
	String email = request.getParameter("Email");
	String phone = request.getParameter("Phone");
	
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
	String sqll ="select u.person_id from users u where u.user_name ='"+userId+"'";
    ResultSet rsett = null;
    try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sqll);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
    int user=0;
    if(rsett.next()){
		user= Integer.parseInt(rsett.getString(1));
		
	}
    out.println(user+" name");
    String sqls="UPDATE persons SET first_name ='"+firstNa+"', last_name ='"+lastNa+"',address = '"+address+"', email = '"+email+"', phone = '"+phone+"' WHERE person_id = '"+user+"'";
    String sqlu="UPDATE users SET  password ='"+password+"'  WHERE person_id = '"+user+"'";
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
    if(userType.equals("a")){
    response.sendRedirect("loginSuc.jsp?user="+userId);
    }else if(userType.equals("d")){
        response.sendRedirect("loginSucD.jsp?user="+userId);
     }else if(userType.equals("r")){
    	    response.sendRedirect("loginSucR.jsp?user="+userId);
     }else if(userType.equals("p")){
    	    response.sendRedirect("loginSucP.jsp?user="+userId);
     }

}else
{
    out.println("You have to write your user name and password");
}  
%>


</BODY>
</HTML>
