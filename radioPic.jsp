<HTML>
<HEAD>
<TITLE>Upload</TITLE>
</HEAD>

<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.io.*"%>
	<%@ page import="javax.servlet.*"%>
	<%@ page import="javax.servlet.http.*"%>
	<%@ page import="java.util.*"%>
	<%@ page import="oracle.sql.*"%>
	<%@ page import="oracle.jdbc.*"%>
	<%@ page import="java.awt.Image"%>
	<%@ page import="java.awt.image.BufferedImage"%>
	<%@ page import="javax.imageio.ImageIO"%>
	<%@ page import="org.apache.commons.fileupload.DiskFileUpload"%>
	<%@ page import="org.apache.commons.fileupload.FileItem"%>
	<%!
public static BufferedImage shrink(BufferedImage image, int n) {

    int w = image.getWidth() / n;
    int h = image.getHeight() / n;

    BufferedImage shrunkImage =
        new BufferedImage(w, h, image.getType());

    for (int y=0; y < h; ++y)
        for (int x=0; x < w; ++x)
            shrunkImage.setRGB(x, y, image.getRGB(x*n, y*n));

    return shrunkImage;
}
%>
	<%!
private static Connection getConnected( String drivername,
	    String dbstring,
	    String username, 
	    String password  ) 
throws Exception {
Class drvClass = Class.forName(drivername); 
DriverManager.registerDriver((Driver) drvClass.newInstance());
return( DriverManager.getConnection(dbstring,username,password));
} 

%>


	<% 
	//upload pictures
	int checknum=0;
	String str = (String)session.getAttribute("use");
	String name = (String)session.getAttribute("userName");
	out.println("name"+name);
	int rec_id = Integer.parseInt(str);

	//  change the following parameters to connect to the oracle database

	String username = "cye2";
	String password = "Jeff1992";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    	
    	
	int pic_id;
	String response_message="baga";
	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    List FileItems = fu.parseRequest(request);
	   
	    // Process the uploaded items, assuming only 1 image file uploaded
	    Iterator i = FileItems.iterator();
	    FileItem item = null;
	    
	    //String response_message="";
	    
	    while (i.hasNext()) {
			item = (FileItem)i.next();
			if(item!=null){
				InputStream instream = item.getInputStream();
				BufferedImage img = ImageIO.read(instream);
				out.println("lol");
				if(img==null){
					break;	
				}
				BufferedImage thumbNail = shrink(img, 10);
	    		BufferedImage normal = shrink(img, 2);
	    		out.println("lol");
            // Connect to the database and create a statement
				Connection conn = getConnected(drivername,dbstring, username,password);
	    		Statement stmt = conn.createStatement();
	    

	    		out.println("lol");
	    		ResultSet rset1 = stmt.executeQuery("SELECT pic_id.nextval from dual");
	    		rset1.next();
	    		pic_id = rset1.getInt(1);
	    	//out.println("lol");
	    	//}
	    		out.println("lol pic"+pic_id+" rec:"+rec_id);
	    		stmt.execute("INSERT INTO pacs_images VALUES("+rec_id+","+pic_id+",empty_blob(),empty_blob(),empty_blob())");
	    		out.println("lol");
	    		String cmd = "SELECT * FROM pacs_images WHERE image_id = "+pic_id+" FOR UPDATE";
	    		ResultSet rset = stmt.executeQuery(cmd);
	    		out.println("lol");
	    		BLOB full = null;
	    		BLOB regular = null;
	    		BLOB small = null;
	    		out.println("lol1");
	    		while(rset.next())
	    		{	
	    			out.println("lol1");
	    			full = ((OracleResultSet)rset).getBLOB("full_size");
	    			regular = ((OracleResultSet)rset).getBLOB("regular_size");
	    			small = ((OracleResultSet)rset).getBLOB("thumbnail");
	   	 		}
	    //Write the image to the blob object
	    		OutputStream outstreamfull = full.getBinaryOutputStream();
	    		OutputStream outstreamreg = regular.getBinaryOutputStream();
	    		OutputStream outstreamsmall = small.getBinaryOutputStream();
	    		ImageIO.write(thumbNail, "jpg", outstreamsmall);
	    		ImageIO.write(normal, "jpg", outstreamreg);
	    		ImageIO.write(img, "jpg", outstreamfull);
	    		instream.close();
	    		outstreamfull.close();
	    		outstreamreg.close();
	    		outstreamsmall.close();
	    		out.println("commit");
	    		checknum=1;
          		stmt.executeUpdate("commit");
	    		response_message = " Upload OK!  ";
	    		out.println("lol1");
            	response.setContentType("text/html");

        		
        	conn.close();
		   }
		}
	} catch( Exception ex ) {
	    //System.out.println( ex.getMessage());
	    response_message = ex.getMessage();
	}
	
	//Output response to the client
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
        		    "Transitional//EN\">\n" +
        		    "<HTML>\n" +
        		    "<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
        		    "<BODY>\n" +
        		    "<H1>" +
        		            response_message +
        		    "</H1>\n" +
        		    "</BODY></HTML>");
    
	 if (checknum==1){
		 
		 response.sendRedirect("loginSucR.jsp?user="+name);
	 }
    /*
      /*   To connect to the specified database
    */

    
%>
<%
out.println(name+"name1");
%>

</body>
</HTML>