
<html>
<head> 
<title>Sample program -- Upload image</title> 
<link rel="stylesheet" href="css/style.css" type="text/css">
<a href="help.html">HELP</a>
</head>

<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<body><center>
<%@ page import="java.sql.*" %>
<%
String patient_id = request.getParameter("recordBB");
String userName=request.getParameter("userNN");
out.println("name"+userName);
session.setAttribute("use", patient_id);
session.setAttribute("userName", userName);
%>
Please input or select the path of the image!
<form name="upload-image" method="POST" enctype="multipart/form-data" action="radioPic.jsp">
<table>
  <tr>
    <th>File path: </th>
    <td><input name="file-path" type="file" size="60" multiple="multiple" ></input></td>
  </tr>
  

  <tr>
    <td ALIGN=CENTER COLSPAN="2"><input type="submit" name=".submit" 
     value="Upload"></td>
  </tr>
</table>
</form>
</center>
</body>
</html>
