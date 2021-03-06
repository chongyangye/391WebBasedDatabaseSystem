<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <title>Inverted Index example</title>
  <link rel="stylesheet" href="css/style.css" type="text/css">
  </head>
  <a href="login.html" style="float: right;">Log out</a>
  <a href="help.html">HELP</a>
  <body>
<STYLE>H2 {FONT-SIZE: 21pt; COLOR: maroon};  </STYLE>
<center>
<H2>Searching Module of Doctor</H2>
</center> 	
<hr>
    <br>
    <!--the code below is to connect the sqldevelop -->
    <%

      String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      String m_driverName = "oracle.jdbc.driver.OracleDriver";
      
      String m_userName = "cye2"; //supply username
      String m_password = "Jeff1992"; //supply password
      
      
      String addItemError = "";
      ArrayList<String> a_list = new ArrayList<String>();
      a_list.add("Null");
      a_list.add("Ranked");
      a_list.add("By Time");
	
      int imageID;

      Connection m_con;
      String createString;
      Statement stmt;
      
      try
      {
      
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
        m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        
      } 
      catch(Exception e)
      {      
        out.print("Error displaying data: ");
        out.println(e.getMessage());
        return;
      }
      
      try
      {
                  
        Statement sta = null;
        ResultSet rset1 = null;
        String doctorID = "";
        
        String query_infor = "SELECT person_id from log_in";
        try{
        	sta = m_con.createStatement();
        	rset1 = sta.executeQuery(query_infor);
        }catch(Exception ex)
        {
        	out.println("what is that.");
        }
        if (rset1!= null && rset1.next() )
        {
        	doctorID = rset1.getString(1);
        }
        

    %>

   <!-- code above is all the input box  -->
    <b><%=addItemError%></b><br>
    <form name=insertData method=post action=search_doctor.jsp> 
     <center>	
      <table>
       <tr>
	<td>
	    Patient name:
	</td>
          <td>
            <input type=text name=pfirst_name placeholder="First_name">
          </td>
	  <td>
          </td>
	  <td>
            <input type=text name=plast_name placeholder="Last_name">
          </td>
        </tr>
	<tr>
	<td>
	    Radiologist name:
	</td>
          <td>
            <input type=text name=rfirst_name placeholder="First name">
          </td>
	  <td>
          </td>
	  <td>
            <input type=text name=rlast_name placeholder="Last name">
          </td>
        </tr>

	</tr>
	<tr>
        <td>
	    Tprescribing_date From:
	</td>
          <td>
            <input type=text name=prescribing_date_from placeholder="DD-MM-YY">
          </td>
	  <td>
            to:
          </td>
          <td>
            <input type=text name=prescribing_date_to placeholder="DD-MM-YY">
          </td>
	</tr>
	<tr>
        <td>
	    Test_date From:
	</td>
          <td>
            <input type=text name=test_date_from placeholder="DD-MM-YY">
          </td>
	  <td>
            to:
          </td>
          <td>
            <input type=text name=test_date_to placeholder="DD-MM-YY">
          </td>
	</tr>
	<tr>
        <td>
	    Diagnosis:
	</td>
          <td>
            <input type=text name=Dia placeholder="key words">
          </td>
	</tr>
	<tr>
        <td>
	    Discrib:
	</td>
          <td>
            <input type=text name=dis placeholder="key words">
          </td>
	</tr>

	<tr>
        <td>
	    Test_Type:
	</td>
          <td>
            <input type=text name=test_type placeholder="key words">
          </td>
	</tr>
	<br>
	<br>
	<tr>
	<td>
	</td>
	<td>
	</td>
	</tr>
      </table>
	</center>
          <table>
	<tr>
	  <td>
	    Sorted By:
	  </td>
	<tr>
	  <td>
		<!--show the list item -->
		<select name = "item" >
		<%
			for (int i =0;i<a_list.size();i++)
			{
			    String anser = a_list.get(i);
			    out.println("<option value=\""+anser+"\">"+anser+"</opition>");	
			};				
		%>
	  </td>
	</tr>
	<tr>
	<center>
	<td>
	</td>
	<td>
	</td>
	<td>
            <input type=submit value="Search" name="search">
        </td>
	</center>
	</tr>

            </select>
	</tr>

    </table>
	<!--code below is the query for searching -->
      <%
	  // the all the counter count the order of the input and give each a value
          int counter = 0;
	  int counter_dis =0;
          int counter_dia =0;
	  int counter_test = 0;  
	  int counter_test_from =0;
          int counter_test_to= 0;
	  int counter_prescribing_to = 0;
          int counter_prescribing_from = 0;
	  int counter_radi_first = 0;
	  int counter_radi_last = 0;
	  int counter_pati_first = 0;
	  int counter_pati_last = 0;



          if (request.getParameter("search") != null)
          {
        	
          
          	//this is the basic query
		String self_query = "SELECT rr.record_id, p1.first_name AS doc_first_name, p1.last_name AS doc_last_name, p2.first_name AS pati_first_name, p2.last_name AS pati_last_name, p3.first_name AS radi_first_name, p3.last_name AS radi_last_name, rr.test_type, rr.prescribing_date, rr.test_date, rr.diagnosis, rr.description, pi.image_id FROM radiology_record rr, persons p1, persons p2, persons p3, pacs_images pi WHERE rr.doctor_id = p1.person_id AND rr.patient_id = p2.person_id AND rr.radiologist_id = p3.person_id AND rr.record_id = pi.record_id AND p1.person_id = "+doctorID+" ";
		//out.println(self_query);
          
		String Query_end = " ORDER BY ";
		String Query_endend = " DESC";

		String Query_discrib = " AND contains(description, ? , 2) > 0 ";
		
		String Query_diagnosis = " AND contains(diagnosis, ? , 1) > 0 ";
		
		String Query_test = " AND contains(test_type, ? , 3) > 0 ";
		
		String Query_test_to =" AND rr.test_date <= ? ";
		
		String Query_test_from =" AND rr.test_date >= ? ";

		String Query_prescribing_from =" AND rr.prescribing_date >= ? ";
		
		String Query_prescribing_to = " AND rr.prescribing_date <= ? ";

		String Query_radi_first = " AND contains(p3.first_name, ?, 4) > 0 ";

		String Query_radi_last = " AND contains(p3.last_name, ?, 5) > 0 ";

		String Query_pati_first = " AND contains(p2.first_name, ?, 6) > 0 ";

		String Query_pati_last = " AND contains(p2.last_name, ?, 7) > 0 ";




		if(!(request.getParameter("test_date_from").equals("")))
            	{
		      self_query = self_query + Query_test_from;
		      counter = counter+1;
		      counter_test_from = counter;
		}

		if(!(request.getParameter("test_date_to").equals("")))
	        {
		      self_query = self_query + Query_test_to;
		      counter = counter+1;
		      counter_test_to = counter;
	    	}	

		if(!(request.getParameter("prescribing_date_from").equals("")))
                {
		      self_query = self_query + Query_prescribing_from;
		      counter = counter+1;
		      counter_prescribing_from = counter;
	        }
		if(!(request.getParameter("prescribing_date_to").equals("")))
            	{
		      self_query = self_query + Query_prescribing_to;
		      counter = counter+1;
		      counter_prescribing_to = counter;
	        }

		if(!(request.getParameter("test_type").equals("")))
            	{
		      self_query = self_query + Query_test;
		      counter = counter+1;
		      counter_test = counter;
	        }		
	 	
		if(!(request.getParameter("dis").equals("")))
            	{
		    if(counter ==0)
		     {
	              self_query = self_query + Query_discrib;
		      Query_end = Query_end +" score(2) ";
		      counter = counter+1;
		      counter_dis = counter;
		     }
		     else
		     {
		      self_query = self_query + Query_discrib;
		      Query_end = Query_end +" + "+" score(2) ";
		      counter = counter+1;
		      counter_dis = counter;
		     }
	    	}
	
		if(!(request.getParameter("Dia").equals("")))
            	{
		    if (counter == 0)
		     {
	              self_query = self_query + Query_diagnosis;
		      Query_end = Query_end +" 3*(score(1)) ";
		      counter = counter+1;
		      counter_dia = counter;
		     }
		    else
		     {
		      self_query = self_query + Query_diagnosis;
		      Query_end = Query_end +" + "+" 3*(score(1)) ";
		      counter = counter+1;
		      counter_dia = counter;
		     }
	    	}

		if(!(request.getParameter("rfirst_name").equals("")))
            	{
	              self_query = self_query + Query_radi_first;
		      counter = counter+1;
		      counter_radi_first = counter;
	    	}

		if(!(request.getParameter("rlast_name").equals("")))
            	{
	              self_query = self_query + Query_radi_last;
		      counter = counter+1;
		      counter_radi_last = counter;
	    	}

		if(!(request.getParameter("pfirst_name").equals("")))
            	{
		     if(counter == 0 )
		     {
	              self_query = self_query + Query_pati_first;
		      Query_end = " ORDER BY 6*score(6) ";
		      counter = counter+1;
		      counter_pati_first = counter;
		     }
		    else
		    {
		      self_query = self_query + Query_pati_first;
		      Query_end = Query_end + " + " +" 6*(score(6)) ";
		      counter = counter+1;
		      counter_pati_first = counter;
		    }
	    	}

		if(!(request.getParameter("plast_name").equals("")))
            	{
		    if(counter ==0)
		     {
	              self_query = self_query + Query_pati_last;
		      Query_end = Query_end +" 6*(score(7)) ";
		      counter = counter+1;
		      counter_pati_last = counter;
		     }
		    else
		     {
		      self_query = self_query + Query_pati_last;
		      Query_end = Query_end +" + "+" 6*(score(7)) ";
		      counter = counter+1;
		      counter_pati_last = counter;
		     }
	    	}



		if(!(request.getParameter("test_date_from").equals("")))
            	{
		      self_query = self_query + Query_test_from;
		      counter = counter+1;
		      counter_test_from = counter;
		}
		if((request.getParameter("item").equals("Ranked")))
            	{
			Query_end = Query_end; 
	    	}
		if((request.getParameter("item").equals("By Time")))
            	{
	      	      Query_end = " ORDER BY test_date  ";
	    	}
		if((request.getParameter("item").equals("Null")))
            	{
	      	      Query_end = " ORDER BY test_date  ";
	    	}



        PreparedStatement doSearch = m_con.prepareStatement(self_query+Query_end+Query_endend);
	  

	if(!(request.getParameter("dis").equals("")))
            	{
	      	      String display =  request.getParameter("dis");
	              doSearch.setString(counter_dis, display);
	    	}

		if(!(request.getParameter("test_type").equals("")))
            	{
	              String test1 =  request.getParameter("test_type");
	              doSearch.setString(counter_test, test1);
	    	}

		if(!(request.getParameter("test_date_from").equals("")))
	        {
		      String test_datefrom =  request.getParameter("test_date_from");
		      doSearch.setString(counter_test_from, test_datefrom);
		}

		if(!(request.getParameter("test_date_to").equals("")))
            	{
		      String test_dateto =  request.getParameter("test_date_to");
		      doSearch.setString(counter_test_to, test_dateto);
	    	}

		if(!(request.getParameter("prescribing_date_from").equals("")))
            	{
	      	      String prescribing_datefrom =  request.getParameter("prescribing_date_from");
	      	      doSearch.setString(counter_prescribing_from, prescribing_datefrom);
	    	}

		if(!(request.getParameter("prescribing_date_to").equals("")))
            	{
	     	      String prescribing_dateto =  request.getParameter("prescribing_date_to");
	              doSearch.setString(counter_prescribing_to, prescribing_dateto);
	    	}
  
	 	if(!(request.getParameter("Dia").equals("")))
            	{
	      	      String dia =  request.getParameter("Dia");
	              doSearch.setString(counter_dia, dia);
	    	}
 
  
		if(!(request.getParameter("rfirst_name").equals("")))
            	{
	      	      String rfn =  request.getParameter("rfirst_name");
	              doSearch.setString(counter_radi_first, rfn);
	    	}

		if(!(request.getParameter("rlast_name").equals("")))
            	{
	      	      String rln =  request.getParameter("rlast_name");
	              doSearch.setString(counter_radi_last, rln);
	    	}

		if(!(request.getParameter("pfirst_name").equals("")))
            	{
	      	      String pfn =  request.getParameter("pfirst_name");
	              doSearch.setString(counter_pati_first, pfn);
	    	}

		if(!(request.getParameter("plast_name").equals("")))
            	{
	      	      String pln =  request.getParameter("plast_name");
	              doSearch.setString(counter_pati_last, pln);
	    	}

	   
	    String recordID1;
        ResultSet rset2 = doSearch.executeQuery();
		
            boolean hasnext = false;
	    if(rset2 != null && rset2.next())
		{
		  hasnext = true;
		}
	    //the table print
	    out.println("<left>");
            out.println("<table class = "+"\""+"zebra"+"\""+">");
	    out.println("<caption>Searching Result</caption>");
            out.println("<tr>");
            out.println("<th>Record ID</th>");
            out.println("<th>Doctor First Name</th>");
            out.println("<th>Doctor Last Name</th>");
            out.println("<th>Patient First Name</th>");
            out.println("<th>Patient Last Name</th>");
            out.println("<th>Radiologist First Name</th>");
            out.println("<th>Radiologist Last Name</th>");
            out.println("<th>Test Type</th>");
            out.println("<th>Prescribing Date</th>");
            out.println("<th>Test Date</th>");
            out.println("<th>Diagnosis</th>");
            out.println("<th>Discription</th>");
	    out.println("<th>Image</th>");
            out.println("</tr>");
            while (hasnext){
              out.println("<tr>");
              out.println("<td>");
              out.println(rset2.getString(1));
	      recordID1 = rset2.getString(1);
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(2));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(3));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(4));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(5));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(6));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(7));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(8));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(9));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(10));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(11));
              out.println("</td>");
              out.println("<td>");
              out.println(rset2.getString(12));
              out.println("</td>");
	      out.println("<td>");
	      imageID = rset2.getInt(13);
	
	      
              out.println("<a href=\"GetOnePic?" + imageID + "\"><img src=\"GetOnePic?" + imageID +"\" style=\"display:block; width:100px; height:auto;\"></a>");
	       
             hasnext = rset2.next();
	     while (hasnext &&(rset2.getString(1).equals(recordID1)))
		 {
                	imageID = rset2.getInt(13);
                	out.println("<a href=\"GetOnePic?" + imageID + "\"><img src=\"GetOnePic?" + imageID +"\" style=\"display:block; width:100px; height:auto;\"></a>");
		        hasnext = rset2.next();
         	 }
	    


	   
             out.println("</td>");
             out.println("</tr>");
             out.println("</tr>");
            } 
            out.println("</table>");
	    out.println("</div>");
         
          }
          m_con.close();
        }
        catch(SQLException e)
        {
          out.println("please enter the right things to search "+"SQLException: " +
          e.getMessage());
			m_con.rollback();
        }
      %>
    </form>
  </body>
</html>


