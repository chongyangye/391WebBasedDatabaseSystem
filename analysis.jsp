<html>
<head>

<a href="help.html">HELP</a>
</head>
<link rel="stylesheet" href="css/style.css" type="text/css">
<body><Center>



<H1 bgcolor=#0000ff><CENTER>Welcome Administrator: Date Analysis</H1>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<%@ page import="java.sql.*" %>
<%
//This page is use to analysis data, by check the patient, 
//test_type, date and the way they want to see (year, month,week)
String diago= request.getParameter("diagno");
String yearS= request.getParameter("yearS");
String monS= request.getParameter("monS");
String dayS= request.getParameter("dayS");
String yearE= request.getParameter("yearE");
String monE= request.getParameter("monE");
String dayE= request.getParameter("dayE");
String date1= (dayS+"-"+monS+"-"+yearS);
String date2= (dayE+"-"+monE+"-"+yearE);
int checkDateS=0;
int checkDateE=0;
int checkPatient = 0;
int checkTest=0;
int checkYear=0;
int checkMonth=0;
int checkWeek=0;
//get the date clear
if(yearS.equals("null")){
	checkDateS=0;
	if(monS.equals("null")){
		if(dayS.equals("null")){
			checkDateS=0;
		}
	}
}else{
	checkDateS=1;
	if(monS.equals("null")){
		date1= ("01-JAN-"+yearS);
	}else{
		if(dayS.equals("null")){
			date1= ("01-"+monS+"-"+yearS);
		}else{
			date1= (dayS+"-"+monS+"-"+yearS);
		}
	}
}

if(yearE.equals("null")){
	checkDateE=0;
	if(monE.equals("null")){
		if(dayE.equals("null")){
			checkDateE=0;
		}
	}
}else{
	checkDateE=1;
	if(monE.equals("null")){
		date2= ("01-JAN-"+yearE);
	}else{
		if(dayE.equals("null")){
			date2= ("01-"+monE+"-"+yearE);
		}else{
			date2= (dayE+"-"+monE+"-"+yearE);
		}
	}
}

//check patient
String patientId= request.getParameter("patientID");
int patient_id=0;
if(patientId.equals("null")){
	checkPatient=0;
	patient_id=0;
}else{
	checkPatient=1;
	patient_id = Integer.parseInt(patientId);
}

//check type
String testType = request.getParameter("type");
if(testType.equals("null")){
	checkTest=0;
}else{
	checkTest=1;
}

//check year
String year=request.getParameter("year");
if(year==null){
	checkYear=0;
	
}else if(year.equals("year")){
	checkYear=1;
}else if(year.equals("month")){
	checkMonth=1;
	
}else if(year.equals("week")){
	checkWeek=1;
}



//start to connect database

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
	  		String sql="";
	  		//1select all, everything is null
	  		if(checkPatient==0 && checkTest==0 && checkDateS==0 && checkDateE==0){
	  			
	  			sql ="from pacs_images p, radiology_record r, persons p1 where p1.person_id = r.patient_id AND r.record_id = p.record_id group by p1.person_id, r.test_type, p1.first_name";
	  			String groupBy="";
	  			String tableName="";
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  					sql = "select count(p.image_id), p1.person_id, p1.first_name, r.test_type ";
	  					groupBy= "GROUP BY p1.person_id, p1.first_name, r.test_type";
	  			}else if(checkYear==1){
	  				tableName="year";
	  				sql = "SELECT count(p.image_id), EXTRACT(YEAR FROM r.test_date) AS year, p1.person_id, p1.first_name, r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date), p1.person_id, p1.first_name, r.test_type";
	  			}else if(checkMonth==1){
	  				tableName="month";
	  				sql = "SELECT count(p.image_id), EXTRACT(Month FROM r.test_date) AS month, p1.person_id, p1.first_name, r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date), p1.person_id, p1.first_name, r.test_type";
	  			}else if(checkWeek==1){
	  				tableName="week";
	  				sql = "SELECT count(p.image_id), to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week, p1.person_id, p1.first_name, r.test_type ";
	  				groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')), p1.person_id, p1.first_name, r.test_type";
	  			}
	  			sql = sql+ "from pacs_images p, radiology_record r, persons p1 where p1.person_id = r.patient_id AND r.record_id = p.record_id " + groupBy;
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  				try{
			        	stmt = conn.createStatement();
				        rsett = stmt.executeQuery(sql);
		        	}
			
			        catch(Exception ex){
				        out.println("<hr>" + ex.getMessage() + "<hr>");
		        	}
		  			%>
	  				<table border="2">
	  				<tr><td>Name</td><td>Paitent ID</td><td>Test Type</td><td>Number of Images</td></tr>
	  				
	  				<%
	  				while(rsett.next()){
	  	        		%>
	  	        		<tr><td><%=rsett.getString(3)%></td><td><%= rsett.getString(2)%></td><td><%= rsett.getString(4)%></td><td><%=rsett.getString(1)%>
	  	        		</td></tr>
	  	        		<% 
	  	    
	  	        	}
	  	        	
	  	        	%>
	  				</table>
	  				
	  				<%
	  			}else{
	  			try{
		        	stmt = conn.createStatement();
			        rsett = stmt.executeQuery(sql);
	        	}
		
		        catch(Exception ex){
			        out.println("<hr>" + ex.getMessage() + "<hr>");
	        	}
	  			%>
  				<table border="2">
  				<tr><td>Name</td><td>Paitent ID</td><td>Test Type</td><td>GroupBy Time</td><td>Number of Images</td></tr>
  				
  				<%
  				while(rsett.next()){
  	        		%>
  	        		<tr><td><%=rsett.getString(4)%></td><td><%= rsett.getString(3)%></td><td><%= rsett.getString(5)%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
  	        		</td></tr>
  	        		<% 
  	    
  	        	}
  	        	
  	        	%>
  				</table>
  				
  				<%
	  			}
	  		}
	  		//2select specific patient with other situations.
	  		else if(checkPatient==1 ){
	  			String groupBy="";
	  			String tableName="";
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  				if(checkTest==1){
	  					sql = "select count(p.image_id) ";
	  				}else{
	  					sql="select count(p.image_id), r.test_type ";
	  					groupBy = "GROUP BY r.test_type ";
	  				}
	  			}else if(checkYear==1){
	  				tableName="year";
	  				if(checkTest==1){
	  					sql = "SELECT count(p.image_id), EXTRACT(YEAR FROM r.test_date) AS year ";
	  					groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date)";
	  				}else{
	  					sql = "SELECT count(p.image_id), r.test_type, EXTRACT(YEAR FROM r.test_date) AS year ";
	  					groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date), r.test_type";
	  				}
	  			}else if(checkMonth==1){
	  				tableName="month";
	  				if(checkTest==1){
	  					sql = "SELECT count(p.image_id), EXTRACT(Month FROM r.test_date) AS month ";
	  					groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date)";
	  				}else{
	  					sql = "SELECT count(p.image_id), r.test_type, EXTRACT(Month FROM r.test_date) AS month ";
	  					groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date), r.test_type";
	  				}
	  				
	  			}else if(checkWeek==1){
	  				tableName="week";
	  				if(checkTest==1){
	  					sql = "SELECT count(p.image_id), to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week ";
	  					groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW'))";
	  				}else{
	  					sql = "SELECT count(p.image_id), r.test_type, to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week ";
	  					groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')), r.test_type";
	  				}
	  			}
	  			String out1="";
	  			if(checkTest ==1){
	  				if(checkDateS ==1){
	  					if(checkDateE==1){
	  						sql = sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_type ='"+testType+"' AND r.test_date between '"+date1+"' and '"+date2+"' "+groupBy;
	  						out1 = " on '"+testType+"' between '"+date1+"' and '"+date2+"'";
	  					}else{
	  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_type ='"+testType+"' AND r.test_date > '"+date1+"' "+groupBy;
	  			  			out1 = " on '"+testType+"' after '"+date1+"'";
	  					}
	  				}else{
	  					if(checkDateE==1){
	  						sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_type ='"+testType+"' AND r.test_date < '"+date2+"' "+groupBy;
	  						out1 = " on '"+testType+"' before '"+date2+"'";
	  					}else{
	  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_type ='"+testType+"' "+groupBy;
	  			  			out1 = " on '"+testType+"'";
	  					}
	  				}
	  			}else{
	  				if(checkDateS ==1){
	  					if(checkDateE==1){
	  						sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_date between '"+date1+"' and '"+date2+"' "+groupBy;
	  						out1 = " between '"+date1+"' and '"+date2+"'";
	  					}else{
	  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_date > '"+date1+"' "+groupBy;
	  			  			out1 = "  after '"+date1+"'";
	  					}
	  				}else{
	  					if(checkDateE==1){
	  						sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' AND r.test_date < '"+date2+"' "+groupBy;
	  						out1 = " before '"+date2+"'";
	  					}else{
	  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND p1.person_id = '"+patient_id+"' "+groupBy;
							out1 = "";
	  					}
	  				}
	  				
	  			}
	  			//out.println(sql);
	  			//sql =" select count(p.image_id) from pacs_images p, persons p1, radiology_record r where p1.person_id = "+patient_id+" AND p1.person_id = r.patient_id AND r.record_id = p.record_id";
	  			String sql2 =" select p1.first_name from persons p1 where p1.person_id = "+patient_id+" ";
  				String name="";
  				try{
	        		stmt = conn.createStatement();
		        	rsett = stmt.executeQuery(sql2);
        		}
	
	        	catch(Exception ex){
		        	out.println("<hr>" + ex.getMessage() + "<hr>");
        		}
  				if(rsett.next()){
  					name=rsett.getString(1);
  				
  				}
  				
  				//output
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0 && checkTest==1){
	  				try{
		        		stmt = conn.createStatement();
			        	rsett = stmt.executeQuery(sql);
	        		}
		
		        	catch(Exception ex){
			        	out.println("<hr>" + ex.getMessage() + "<hr>");
	        		}
	  				int num=0;
	  				if(rsett.next()){
	  					num=Integer.parseInt(rsett.getString(1));
	  				
	  				}
	  				
	  				out.println(name+" has "+num+" pics" +out1);
	  			}else if(checkYear==0 && checkMonth==0 && checkWeek ==0 && checkTest==0){
	  				try{
		        		stmt = conn.createStatement();
			        	rsett = stmt.executeQuery(sql);
	        		}
		
		        	catch(Exception ex){
			        	out.println("<hr>" + ex.getMessage() + "<hr>");
	        		}
	  				%>
	  				<table border="2">
	  				<tr><td>Name</td><td>Test type</td><td>Number of Images</td></tr>
	  				
	  				<%
	  				while(rsett.next()){
	  	        		%>
	  	        		<tr><td><%=name%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
	  	        		</td></tr>
	  	        		<% 
	  	    
	  	        	}
	  	        	
	  	        	%>
	  				</table>
	  				
	  				<%
	  			}else{
	  				if(checkTest ==1){
	  					try{
		        			stmt = conn.createStatement();
			        		rsett = stmt.executeQuery(sql);
	        			}
		
		        		catch(Exception ex){
			        		out.println("<hr>" + ex.getMessage() + "<hr>");
	        			}
	  				%>
	  				<table border="2">
	  				<tr><td>Name</td><td><% out.println(tableName);%></td><td>Number of Images</td></tr>
	  				
	  				<%
	  				while(rsett.next()){
	  	        		%>
	  	        		<tr><td><%=name%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
	  	        		</td></tr>
	  	        		<% 
	  	    
	  	        	}
	  	        	
	  	        	%>
	  				</table>
	  				
	  				<%
	  				}else if(checkTest ==0){
	  					try{
		        			stmt = conn.createStatement();
			        		rsett = stmt.executeQuery(sql);
	        			}
		
		        		catch(Exception ex){
			        		out.println("<hr>" + ex.getMessage() + "<hr>");
	        			}
	  				%>
	  				<table border="2">
	  				<tr><td>Name</td><td><% out.println(tableName);%></td><td>Test type</td><td>Number of Images</td></tr>
	  				
	  				<%
	  				while(rsett.next()){
	  	        		%>
	  	        		<tr><td><%=name%></td><td><%= rsett.getString(3)%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
	  	        		</td></tr>
	  	        		<% 
	  	    
	  	        	}
	  	        	
	  	        	%>
	  				</table>
	  				
	  				<%
	  				}
	  			}
	  		}//3select a specific test type 
	  		else if(checkPatient==0 && checkTest==1){
	  			String groupBy="";
	  			String tableName="";
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  					sql = "select count(p.image_id) ";
	  			}else if(checkYear==1){
	  				tableName="year";
	  				sql = "SELECT count(p.image_id), EXTRACT(YEAR FROM r.test_date) AS year, p1.first_name, p1.person_id ";
	  				groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date),p1.first_name, p1.person_id";
	  			}else if(checkMonth==1){
	  				tableName="month";
	  				sql = "SELECT count(p.image_id), EXTRACT(Month FROM r.test_date) AS month, p1.first_name, p1.person_id ";
	  				groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date),p1.first_name, p1.person_id";
	  			}else if(checkWeek==1){
	  				tableName="week";
	  				sql = "SELECT count(p.image_id), to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week, p1.first_name, p1.person_id ";
	  				groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')),p1.first_name, p1.person_id";
	  			}
	  			
	  			
	  			
	  			String out1="";
	  			if(checkDateS ==1){
  					if(checkDateE==1){
  						sql = sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND  r.test_type ='"+testType+"' AND r.test_date between '"+date1+"' and '"+date2+"' "+groupBy;
  						out1 = " on '"+testType+"' between '"+date1+"' and '"+date2+"'";
  					}else{
  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND  r.test_type ='"+testType+"' AND r.test_date > '"+date1+"' "+groupBy;
  			  			out1 = " on '"+testType+"' after '"+date1+"'";
  					}
  				}else{
  					if(checkDateE==1){
  						sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND r.test_type ='"+testType+"' AND r.test_date < '"+date2+"' "+groupBy;
  						out1 = " on '"+testType+"' before '"+date2+"'";
  					}else{
  			  			sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND r.test_type ='"+testType+"' "+groupBy;
  			  			out1 = " on '"+testType+"'";
  					}
  				}
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  				
	  			
	  			try{
		        	stmt = conn.createStatement();
			        rsett = stmt.executeQuery(sql);
	        	}
		
		        catch(Exception ex){
			        out.println("<hr>" + ex.getMessage() + "<hr>");
	        	}
	  			int num=0;
	  			if(rsett.next()){
	  				num=Integer.parseInt(rsett.getString(1));
	  			}
	  			
	  			
	  			out.println("There is/are "+num+" pics"+" on "+testType);
	  			}else{
	  				try{
	        			stmt = conn.createStatement();
		        		rsett = stmt.executeQuery(sql);
        			}
	
	        		catch(Exception ex){
		        		out.println("<hr>" + ex.getMessage() + "<hr>");
        			}
  				%>
  				<table border="2">
  				<tr><td>Type</td><td>Name</td><td><% out.println(tableName);%></td><td>Number of Images</td></tr>
  				
  				<%
  				while(rsett.next()){
  	        		%>
  	        		<tr><td><%=testType%></td><td><%= rsett.getString(3)%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
  	        		</td></tr>
  	        		<% 
  	    
  	        	}
  	        	
  	        	%>
  				</table>
  				
  				<%
	  			}
	  		}//4select without patient and checkTest
	  		else if(checkPatient==0 && checkTest==0 && checkDateS==1){
	  			String groupBy="";
	  			String tableName="";
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  					sql = "select count(p.image_id) ";
	  			}else if(checkYear==1){
	  				tableName="year";
	  				sql = "SELECT count(p.image_id), EXTRACT(YEAR FROM r.test_date) AS year, p1.first_name, p1.person_id , r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date),p1.first_name, p1.person_id , r.test_type";
	  			}else if(checkMonth==1){
	  				tableName="month";
	  				sql = "SELECT count(p.image_id), EXTRACT(Month FROM r.test_date) AS month, p1.first_name, p1.person_id, r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date),p1.first_name, p1.person_id, r.test_type";
	  			}else if(checkWeek==1){
	  				tableName="week";
	  				sql = "SELECT count(p.image_id), to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week, p1.first_name, p1.person_id, r.test_type ";
	  				groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')),p1.first_name, p1.person_id, r.test_type";
	  			}
	  			
	  			
	  			String out1="";
	  			if(checkDateE==1){
					sql = sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND r.test_date between '"+date1+"' and '"+date2+"' "+groupBy;
					out1 = " between '"+date1+"' and '"+date2+"'";
				}else{
			  		sql =sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND r.test_date > '"+date1+"' "+groupBy;
			  		out1 = " after '"+date1+"'";
					}
	  			
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  				try{
		        		stmt = conn.createStatement();
			        	rsett = stmt.executeQuery(sql);
	        		}
		
		        	catch(Exception ex){
			        	out.println("<hr>" + ex.getMessage() + "<hr>");
	        		}
	  				int num=1;
	  				if(rsett.next()){
	  					num=Integer.parseInt(rsett.getString(1));
	  				}
	  				out.println ("total "+num+" pics"+out1);
	  			}else{
	  				try{
	        			stmt = conn.createStatement();
		        		rsett = stmt.executeQuery(sql);
        			}
	
	        		catch(Exception ex){
		        		out.println("<hr>" + ex.getMessage() + "<hr>");
        			}
  				%>
  				<table border="2">
  				<tr><td>Type</td><td>Name</td><td><% out.println(tableName);%></td><td>Number of Images</td></tr>
  				
  				<%
  				while(rsett.next()){
  	        		%>
  	        		<tr><td><%=rsett.getString(5)%></td><td><%= rsett.getString(3)%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
  	        		</td></tr>
  	        		<% 
  	    
  	        	}
  	        	
  	        	%>
  				</table>
  				
  				<%
	  			}
	  		}//5only have End date with the above thing empty
	  		else if(checkPatient==0 && checkTest==0 && checkDateS==0 && checkDateE==1){
	  			String groupBy="";
	  			String tableName="";
	  			if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  					sql = "select count(p.image_id) ";
	  			}else if(checkYear==1){
	  				tableName="year";
	  				sql = "SELECT count(p.image_id), EXTRACT(YEAR FROM r.test_date) AS year, p1.first_name, p1.person_id , r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(YEAR FROM r.test_date),p1.first_name, p1.person_id , r.test_type";
	  			}else if(checkMonth==1){
	  				tableName="month";
	  				sql = "SELECT count(p.image_id), EXTRACT(Month FROM r.test_date) AS month, p1.first_name, p1.person_id, r.test_type ";
	  				groupBy= "GROUP BY EXTRACT(MONTH FROM r.test_date),p1.first_name, p1.person_id, r.test_type";
	  			}else if(checkWeek==1){
	  				tableName="week";
	  				sql = "SELECT count(p.image_id), to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')) as week, p1.first_name, p1.person_id, r.test_type ";
	  				groupBy= "GROUP BY to_number(to_char(to_date(r.test_date,'DD-MON-YYYY'),'WW')),p1.first_name, p1.person_id, r.test_type";
	  			}
	  			String out1="";	  		
				sql = sql+"from persons p1, pacs_images p, radiology_record r where  p1.person_id = r.patient_id AND r.record_id = p.record_id AND r.test_date < '"+date2+"' "+groupBy;
				out1 = " before '"+date2+"'";
	  			
				if(checkYear==0 && checkMonth==0 && checkWeek ==0){
	  				try{
		        		stmt = conn.createStatement();
			        	rsett = stmt.executeQuery(sql);
	        		}
		
		        	catch(Exception ex){
			        	out.println("<hr>" + ex.getMessage() + "<hr>");
	        		}
	  				int num=1;
	  				if(rsett.next()){
	  					num=Integer.parseInt(rsett.getString(1));
	  				}
	  				out.println ("total "+num+" pics"+out1);
	  			}else{
	  				try{
	        			stmt = conn.createStatement();
		        		rsett = stmt.executeQuery(sql);
        			}
	
	        		catch(Exception ex){
		        		out.println("<hr>" + ex.getMessage() + "<hr>");
        			}
  				%>
  				<table border="2">
  				<tr><td>Type</td><td>Name</td><td><% out.println(tableName);%></td><td>Number of Images</td></tr>
  				
  				<%
  				while(rsett.next()){
  	        		%>
  	        		<tr><td><%=rsett.getString(5)%></td><td><%= rsett.getString(3)%></td><td><%= rsett.getString(2)%></td><td><%=rsett.getString(1)%>
  	        		</td></tr>
  	        		<% 
  	    
  	        	}
  	        	
  	        	%>
  				</table>
  				
  				<%
	  			}
	  		}
	  		
	  		
	  		
	  		
	  		
	  		
	  		
	  		
%>



</Center>





</body>
</html>
