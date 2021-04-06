<%-- 
    Document   : home
    Created on : 23 Feb, 2021, 2:16:24 PM
    Author     : mohsi
--%>
<%@page import="java.sql.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body{
                background-image: url("images/bus3.jpg");
                height: 100%;

  /* Center and scale the image nicely */
  background-position: inherit;
  background-repeat: no-repeat;
  background-size: cover;
            }
        </style>
    </head>
    <body>
    <center>
        <%

    

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
        ResultSet rs = null;
       
        
            
            //inserting data into db
            String query = "select msg from notice where notice_id = "+1;
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(query);
   

            if (rs.next()) {
            %>
            <marquee style="color:rgb(255, 255, 255); font-size: 30px;"><%= rs.getString("msg") %></marquee>
            <%
              
        }
        
    } catch (Exception e) {
        out.println("Exception" + e.getMessage());
    }

%>
    </center>
    </body>
</html>
