<html>
<head>

<link rel="stylesheet" href="css/style.css" type="text/css">
<a href="help.html" >HELP</a>
</head>
<body><Center>



<H1 bgcolor=#0000ff><CENTER>Welcome Administrator: Date Analysis</H1>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<%@ page import="java.sql.*" %>
<FORM NAME="AnalyForm" ACTION="analysis.jsp"+userName METHOD="post" >
<tr><th>Patient: </th>
  <td><SELECT NAME="patientID">
  <Option value=null>Null</Option>
  <%
  //user may select information they wants to be analysis
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
  	String sql ="select distinct p.first_name, p.person_id from persons p, users u where u.person_id = p.person_id AND u.class ='p'";
  	Statement stmt = null;
  	ResultSet rsett = null;
  	try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sql);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
  	int pid=0;
  	while(rsett.next()){
  		String printt=rsett.getString(1);
  		pid = Integer.parseInt(rsett.getString(2));
  	
  %>
		<Option value=<% out.println(pid);%>><%out.println(printt); %></Option>
<%
  	}
%>
</SELECT>
  </tr>



<tr><th>Test Type: </th>
  <td><SELECT NAME="type">
  <Option value=null>Null</Option>
  <%
  
  	String sql2 ="select distinct r.test_type from radiology_record r ";
  
  	try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sql2);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
  	
  	while(rsett.next()){
  		String printt=rsett.getString(1);
  	
  %>
		<Option value=<% out.println(printt);%>><%out.println(printt); %></Option>
<%
  	}
%>
</SELECT>
  </tr>
  
  <P><TD><B><I>START: YEAR/MON/DAY:</I></B></TD>
<TD><SELECT NAME="yearS">
<Option value=null>Null</Option>
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
<Option value=null>Null</Option>
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
<Option value=null>Null</Option>
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
<Option value=null>Null</Option>
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
<Option value=null>Null</Option>
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
<Option value=null>Null</Option>
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


<P><TD><B><I>Group By:</I></B></TD>
  <SELECT NAME="year">
<Option value=null>Null</Option>
<Option value="year">year</Option>
<Option value="month">month</Option>
<Option value="week">week</Option>

</SELECT>
</P>

<P>
<INPUT TYPE="submit"NAME="click" VALUE="Process" >
</P>
</FORM>





</Center>





</body>
</html>
