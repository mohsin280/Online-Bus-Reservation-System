<%-- 
    Document   : view_bus_details
    Created on : 23 Feb, 2021, 1:07:21 PM
    Author     : mohsi
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public ResultSet searchReserve(Connection con) throws SQLException {

        String check = " SELECT * FROM bus_db.bus";
        Statement stmt = con.createStatement();
        ResultSet r = stmt.executeQuery(check);
        return r;
    }

%>
<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "bus_db";
String userid = "mohsin";
String password = "7009";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
out.println("Exception" + e.getMessage());
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            
            table {
                border-collapse: collapse;
              }
            th {
              height: 50px;
              background-color: #000033;
  color: white;
            }
            th, td {
  padding: 15px;
  text-align: left;
}
        </style>
    </head>
    <body>
    <center>   
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);

resultSet = searchReserve(connection);
if(resultSet.next()){
    
%>
<h1>Bus Details</h1>
<table border="1">
<tr>
<th>Bus ID</th>
<th>From</th>
<th>To</th>
<th>Arrival Time</th>
<th>Departure Time</th>
<th>Type</th>
<th>Fare</th>
<th>Cancel Bus</th>
</tr>
<%do{
     %> 
<tr>
<td><%=resultSet.getInt("bus_id") %></td>
<td><%=resultSet.getString("origin") %></td>
<td><%=resultSet.getString("destination") %></td>
<td><%=resultSet.getString("arrival_time") %></td>
<td><%=resultSet.getString("departure_time") %></td>
<td><%=resultSet.getString("ac") %></td>
<td><%=resultSet.getInt("fare") %></td>
<td><a href="cancel_bus.jsp?id=<%=resultSet.getInt("bus_id") %>">
        <button type="button" class="delete">Cancel Bus</button></a></td>
</tr>
<%
    }while(resultSet.next());
}
else{
%><h1>No buses</h1><%
}

connection.close();
} catch (Exception e) {
e.printStackTrace();
out.println("Exception" + e.getMessage());
}
%>
</table>
</center>
    </body>
</html>

