<html>
<head>
<link rel="stylesheet" href="css/style.css" type="text/css">

</head>
  <a href="login.html" style="float: right;">Log out</a>
  <a href="help.html" >HELP</a>
<script language = "javascript">
<!--

function checkEmpty(){
	if(EditForm.testType.value ==""){
		window.alert("test type can not be empty");
		return false;
	}	
	else if(EditForm.yearS.value =="null"){
		window.alert("prescribing_date can not be empty");
		return false;
	}else if(EditForm.monS.value =="null"){
		window.alert("prescribing_date can not be empty");
		return false;
	}else if(EditForm.dayS.value =="null"){
		window.alert("prescribing_date can not be empty");
		return false;
	}else if(EditForm.yearE.value =="null"){
		window.alert("test_date can not be empty");
		return false;
	}else if(EditForm.monE.value =="null"){
		window.alert("test_date can not be empty");
		return false;
	}else if(EditForm.dayE.value =="null"){
		window.alert("test_date can not be empty");
		return false;
	}	
	else if(EditForm.diagnosis.value ==""){
		window.alert("diagnosis can not be empty");
		return false;
	}
	else if(EditForm.description.value ==""){
		window.alert("description can not be empty");
		return false;
	}
}




-->
</script>
<body><Center>
<%@ page import="java.sql.*" %>
<%
//radiologiest can upload radiology record from this page 
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
	int rID=Integer.parseInt(request.getParameter("Role"));
	String yearS= request.getParameter("yearS");
	String monS= request.getParameter("monS");
	String dayS= request.getParameter("dayS");
	String yearE= request.getParameter("yearE");
	String monE= request.getParameter("monE");
	String dayE= request.getParameter("dayE");
	String date1= (dayS+"-"+monS+"-"+yearS);
	String date2= (dayE+"-"+monE+"-"+yearE);
	String usee=(request.getParameter("userNN"));
	out.println(usee);
	
	if(request.getParameter("recordID")!=null){
		int pID=Integer.parseInt(request.getParameter("recordID"));
		int dID=Integer.parseInt(request.getParameter("DocID"));
		String testTYPE = request.getParameter("testType");
		String dia=request.getParameter("diagnosis");
		String des = request.getParameter("description");
		int record=0;
		String sqls = "select MAX(record_id) from radiology_record";
		try{
	    	stmt = conn.createStatement();
	        rsett = stmt.executeQuery(sqls);
		}

	    catch(Exception ex){
	        out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		if(rsett.next()){
			record = Integer.parseInt(rsett.getString(1));
		}
		record = record +1;
		String sqlInsert="insert into radiology_record values("+record+","+pID+","+dID+","+rID+",'"+testTYPE+"','"+date1+"','"+date2+"','"+dia+"','"+des+"')";
		try{
	    	stmt = conn.createStatement();
	        rsett = stmt.executeQuery(sqlInsert);
	        stmt.executeUpdate("commit");
		}

	    catch(Exception ex){
	        out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		response.sendRedirect("loginSucR.jsp?user="+usee);
	}
		
	
	//close db
	
%>
<FORM NAME="EditForm" ACTION="uploadRad.jsp"+userName METHOD="post" >

<TABLE>
<tr><th>Patient: </th>
  <td><SELECT NAME="recordID">
  <%
  
  	
  String sqll ="select p.first_name, p.person_id from persons p, users u where u.person_id = p.person_id AND u.class = 'p'";
	
  	try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sqll);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
  	int patient_id=0;
  	while(rsett.next()){
  		patient_id = Integer.parseInt(rsett.getString(2));
  		String printt=rsett.getString(1)+":"+rsett.getString(2);
  	
  %>
		<Option value=<%out.println(patient_id); %>><%out.println(printt); %></Option>
<%
  	}
%>
</SELECT>
  </tr>
  
  <tr><th>Doctor: </th>
  <td><SELECT NAME="DocID">
  <%
  String sqlD ="select p.first_name, p.person_id from persons p, users u where u.person_id = p.person_id AND u.class = 'd'";
	
  	try{
    	stmt = conn.createStatement();
        rsett = stmt.executeQuery(sqlD);
	}

    catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}
  	int doc_id=0;
  	while(rsett.next()){
  		doc_id = Integer.parseInt(rsett.getString(2));
  		String printt=rsett.getString(1)+":"+rsett.getString(2);
  	
  %>
		<Option value=<%out.println(doc_id); %>><%out.println(printt); %></Option>
<%
  	}
%>
</SELECT>
  </tr>
  
  
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Test Type:</I></B></TD>
<TD><INPUT TYPE="text" NAME="testType" VALUE=""></TD>
</TR>
<P><TD><B><I>prescribing_date:</I></B></TD>
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
<TD><B><I>test_date:</I></B></TD>
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

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Diagnosis:</I></B></TD>
<TD><INPUT TYPE="text" NAME="diagnosis" VALUE=""></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Description:</I></B></TD>
<TD><INPUT TYPE="text" NAME="description" VALUE=""></TD>
</TR>
</TABLE>
<%
	out.println("<input TYPE ='hidden' name='Role' value ='"+rID+"' >");
	out.println("<input TYPE ='hidden' name='userNN' value ='"+usee+"' >");
%>
<INPUT TYPE="submit"NAME="click" VALUE="Process" ONCLICK="return checkEmpty();" >
</FORM>
<%

try{
        conn.close();
	}
	catch(Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
	}%>

</Center>
</body>
</html>
