<HTML>
<!-- http://jqueryui.com/datepicker/ -->
<HEAD>
<a href="help.html" style="float: right;">HELP</a>


<TITLE>Your Login Result</TITLE>
</HEAD>
<link rel="stylesheet" href="css/style.css" type="text/css">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<body ><CENTER>
<h1>Report Result</h1>
<%@ page import="java.sql.*" %>
<% 
//administor can see the report they want

	if(request.getParameter("diagno")!="" &&request.getParameter("diagno")!=null){
		String diago= request.getParameter("diagno");
		String yearS= request.getParameter("yearS");
		String monS= request.getParameter("monS");
		String dayS= request.getParameter("dayS");
		String yearE= request.getParameter("yearE");
		String monE= request.getParameter("monE");
		String dayE= request.getParameter("dayE");
		String date1= (dayS+"-"+monS+"-"+yearS);
		String date2= (dayE+"-"+monE+"-"+yearE);
		out.println(date1);
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
        	Statement stmt = null;
	     

	        
			
        	//get personID
			String sqll ="select  p.person_id,p.first_name, p.last_name, p.address, p.email, p.phone , to_char(r.test_date,'DD-MM-YYYY') from persons p, "+
        	"radiology_record r where p.person_id = r.patient_id AND r.diagnosis = '"+diago+"' AND r.test_date between '"+date1+"' and '"+date2+"' AND NOT EXISTS (select * from radiology_record r1 where r1.patient_id = r.patient_id AND r1.diagnosis= r.diagnosis AND r.test_date>r1.test_date)";
	        ResultSet rsett = null;
	        try{
	        	stmt = conn.createStatement();
		        rsett = stmt.executeQuery(sqll);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	        %>
			<table border="2">
			<tr><td>First Name</td><td>Last Name</td><td>Address</td><td>Email</td><td>Phone</td><td>Test Date</td></tr>
			
			<%
			while(rsett.next()){
        		%>
        		<tr><td><%=rsett.getString(2)%></td><td><%=rsett.getString(3)%></td><td><%=rsett.getString(4)%>
        		</td><td><%=rsett.getString(5)%></td><td><%=rsett.getString(6)%></td><td>
        		<%=rsett.getString(7)%></td></tr>
        		<% 
    
        	}
        	
        	%>
			</table>
			
			<%
	        
	        
	        
	        
	        
		
	}else{
		
	}

%>




<FORM NAME="reportForm" ACTION="report.jsp" METHOD="post" >

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>specified diagnosis:</I></B></TD>
<TD><INPUT TYPE="text" NAME="diagno" VALUE=""><BR></TD>
</TR>
<P><TD><B><I>START: YEAR/MON/DAY:</I></B></TD>
<TD><SELECT NAME="yearS">
<Option value=2014>2014</Option>
<Option value=2013>2013</Option>
<Option value=2012>2012</Option>
<Option value=2011>2011</Option>
<Option value=2010>2010</Option>
<Option value=2009>2009</Option>
<Option value=2008>2008</Option>
<Option value=2007>2007</Option>
<Option value=2006>2006</Option>
<Option value=2005>2005</Option>
<Option value=2004>2004</Option>
<Option value=2003>2003</Option>
<Option value=2002>2002</Option>
<Option value=2001>2001</Option>
<Option value=2000>2000</Option>
<Option value=1999>1999</Option>
<Option value=1998>1998</Option>
<Option value=1997>1997</Option>
<Option value=1996>1996</Option>
<Option value=1995>1995</Option>
</SELECT>

<SELECT NAME="monS">
<Option value='JAN'>JAN</Option>
<Option value='FEB'>FEB</Option>
<Option value='MAR'>MAR</Option>
<Option value='APR'>APR</Option>
<Option value='MAY'>MAY</Option>
<Option value='JUN'>JUN</Option>
<Option value='JUL'>JUL</Option>
<Option value='AUG'>AUG</Option>
<Option value='SEP'>SEP</Option>
<Option value='OCT'>OCT</Option>
<Option value='NOV'>NOV</Option>
<Option value='DEC'>DEC</Option>
</SELECT>
<SELECT NAME="dayS">
<Option value=01>01</Option>
<Option value=02>02</Option>
<Option value=03>03</Option>
<Option value=04>04</Option>
<Option value=05>05</Option>
<Option value=06>06</Option>
<Option value=07>07</Option>
<Option value=08>08</Option>
<Option value=09>09</Option>
<Option value=10>10</Option>
<Option value=11>11</Option>
<Option value=12>12</Option>
<Option value=13>13</Option>
<Option value=14>14</Option>
<Option value=15>15</Option>
<Option value=16>16</Option>
<Option value=17>17</Option>
<Option value=18>18</Option>
<Option value=19>19</Option>
<Option value=20>20</Option>
<Option value=21>21</Option>
<Option value=22>22</Option>
<Option value=23>23</Option>
<Option value=24>24</Option>
<Option value=25>25</Option>
<Option value=26>26</Option>
<Option value=27>27</Option>
<Option value=28>28</Option>
<Option value=29>29</Option>
<Option value=30>30</Option>
<Option value=31>31</Option>
</SELECT>
</TD>
</P>
<P>
<TD><B><I>END: YEAR/MON/DAY:</I></B></TD>
<TD><SELECT NAME="yearE">
<Option value=2014>2014</Option>
<Option value=2013>2013</Option>
<Option value=2012>2012</Option>
<Option value=2011>2011</Option>
<Option value=2010>2010</Option>
<Option value=2009>2009</Option>
<Option value=2008>2008</Option>
<Option value=2007>2007</Option>
<Option value=2006>2006</Option>
<Option value=2005>2005</Option>
<Option value=2004>2004</Option>
<Option value=2003>2003</Option>
<Option value=2002>2002</Option>
<Option value=2001>2001</Option>
<Option value=2000>2000</Option>
<Option value=1999>1999</Option>
<Option value=1998>1998</Option>
<Option value=1997>1997</Option>
<Option value=1996>1996</Option>
<Option value=1995>1995</Option>
</SELECT>

<SELECT NAME="monE">
<Option value='JAN'>JAN</Option>
<Option value='FEB'>FEB</Option>
<Option value='MAR'>MAR</Option>
<Option value='APR'>APR</Option>
<Option value='MAY'>MAY</Option>
<Option value='JUN'>JUN</Option>
<Option value='JUL'>JUL</Option>
<Option value='AUG'>AUG</Option>
<Option value='SEP'>SEP</Option>
<Option value='OCT'>OCT</Option>
<Option value='NOV'>NOV</Option>
<Option value='DEC'>DEC</Option>
</SELECT>
<SELECT NAME="dayE">
<Option value=01>01</Option>
<Option value=02>02</Option>
<Option value=03>03</Option>
<Option value=04>04</Option>
<Option value=05>05</Option>
<Option value=06>06</Option>
<Option value=07>07</Option>
<Option value=08>08</Option>
<Option value=09>09</Option>
<Option value=10>10</Option>
<Option value=11>11</Option>
<Option value=12>12</Option>
<Option value=13>13</Option>
<Option value=14>14</Option>
<Option value=15>15</Option>
<Option value=16>16</Option>
<Option value=17>17</Option>
<Option value=18>18</Option>
<Option value=19>19</Option>
<Option value=20>20</Option>
<Option value=21>21</Option>
<Option value=22>22</Option>
<Option value=23>23</Option>
<Option value=24>24</Option>
<Option value=25>25</Option>
<Option value=26>26</Option>
<Option value=27>27</Option>
<Option value=28>28</Option>
<Option value=29>29</Option>
<Option value=30>30</Option>
<Option value=31>31</Option>
</SELECT>
</TD>
</P>


<INPUT TYPE="submit"NAME="Reset" VALUE="Report" ONCLICK="return checkRole();">

</FORM>

<a href ="adminManag.jsp">Return</a>

</CENTER>


</BODY>
</HTML>
