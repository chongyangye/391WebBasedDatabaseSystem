<HTML>
<HEAD>


<TITLE><CENTER>Your Login Result</TITLE>
</HEAD>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<body background = "gamersky_028origin_055_201421519157AD.jpg"><CENTER>
<td><font color = white>
<%@ page import="java.sql.*" %>
<% 

        if(request.getParameter("USERID") != null && request.getParameter("PASSWD")!=null)
        {

	        //get the user input from the login page
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
        	out.println("<p>Your input User Name is "+userName+"</p>");
        	out.println("<p>Your input password is "+passwd+"</p>");


	        //establish the connection to the underlying database
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
	        	//establish the connection with my database 
		        conn = DriverManager.getConnection(dbstring,"cye2","Jeff1992");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
	        //select person_id and send this value to the next file
	        String sqlM= "select person_id from users where user_name = '"+userName+"'";
	        try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sqlM);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	        int id=0;
	        if(rset.next()){
	        	id= Integer.parseInt(rset.getString(1));
	        }
	        //find out the corresponding password with user_name 
        	String sql = "select password from users where person_id = '"+id+"'";

        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = null;
			//get password
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
     
	
        	//display the result
	        if(passwd.equals(truepwd)){
		        out.println("<p><b>Your Login is Successful!</b></p>");
	        	//out.println(id);
	        	String userna="";
	        	String sql2 = "select p.first_name from persons p, users u where u.user_name = '"+userName+"' and u.person_id = p.person_id";
	        	try{
		     
			        rset = stmt.executeQuery(sql2);
	        	}
		
		        catch(Exception ex){
			        out.println("<hr>" + ex.getMessage() + "<hr>");
	        	}
		
	        	while(rset != null && rset.next()){
		        	userna = (rset.getString(1)).trim();
	        	
	        	}
	        	String type=null;
	        	//find user's class different class jump to different files
	        	String sql3="select u.class from users u where u.user_name='"+userName+"'";
	        	try{
	   		     
			        rset = stmt.executeQuery(sql3);
	        	}
		
		        catch(Exception ex){
			        out.println("<hr>" + ex.getMessage() + "<hr>");
	        	}
	        	if(rset.next()){
	        		type = rset.getString(1);
	        	}
	        	out.println(type+"type");

			 Statement sta = null;
        

			ResultSet rset_drop = null;
			ResultSet rset_insert = null;

        
       		        String query_drop = "DELETE FROM log_in";
			String query_insert = "INSERT INTO log_in VALUES("+ id +")";
			
        		try{
        			sta = conn.createStatement();
        			rset_drop = sta.executeQuery(query_drop);
				rset_insert = sta.executeQuery(query_insert);
				sta.executeUpdate("commit");
        		}catch(Exception ex)
        		{
        			out.println("what is that.");
        		}
				//user jump to their main page
	        	if(type.equals("a")){
				response.sendRedirect("loginSuc.jsp?user="+userName);
	        	}else if(type.equals("d")){
	        		response.sendRedirect("loginSucD.jsp?user="+userName);
	        	}else if(type.equals("p")){
	        		response.sendRedirect("loginSucP.jsp?user="+userName);
	        	}else if(type.equals("r")){
	        		response.sendRedirect("loginSucR.jsp?user="+userName);
	        	}
			}
        	else{
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");
        	}
                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        else
        {
                out.println("You have to write your user name and password");
        }      
%>
<a href ="login.html">Return</a>
</font></td>

</BODY>
</HTML>
