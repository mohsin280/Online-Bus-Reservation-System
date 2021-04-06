<%-- 
    Document   : add_notice
    Created on : 23 Feb, 2021, 2:34:46 PM
    Author     : mohsi
--%>
<%@page import="java.sql.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String msg = request.getParameter("msg");
try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
        ResultSet rs = null;
       
        
            
            //inserting data into db
            String query = "update notice set msg= "+"'"+ msg+"'"+"  where notice_id = "+1;
            Statement stmt = con.createStatement();
            int i = stmt.executeUpdate(query);
   
            %>
            <script>
                alert('notice is successfully added');
            </script>
            <%
  
              
        
        
    } catch (Exception e) {
        out.println("Exception" + e.getMessage());
    }

%>
