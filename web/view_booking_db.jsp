<%-- 
    Document   : view_booking_db
    Created on : 16 Jan, 2021, 12:41:31 AM
    Author     : mohsi
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public ResultSet searchReserve(Connection con,String username) throws SQLException {

        String check = " SELECT * FROM bus_db.reserve INNER JOIN bus_db.bus ON bus_db.reserve.bus_id = bus_db.bus.bus_id where bus_db.reserve.username=" + "'" + username + "'";
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
String username = (session.getAttribute("sessname")).toString();
connection = DriverManager.getConnection(connectionUrl+database, userid, password);

resultSet = searchReserve(connection, username);
if(resultSet.next()){
    
%>
<h1>My Booking</h1>
<table border="1">
<tr>
<th>Transaction ID</th>
<th>Username</th>
<th>Bus Id</th>
<th>Origin</th>
<th>Destination</th>
<th>Arrival Time</th>
<th>Departure Time</th>
<th>AC/Non AC</th>
<th>Date</th>
<th>Seat</th>
<th>Total Amount</th>
<th>Cancel Ticket</th>
</tr>
<%do{
     %> 
<tr>
<td><%=resultSet.getInt("trans_id") %></td>
<td><%=resultSet.getString("username") %></td>
<td><%=resultSet.getInt("bus_id") %></td>
<td><%=resultSet.getString("origin") %></td>
<td><%=resultSet.getString("destination") %></td>
<td><%=resultSet.getString("arrival_time") %></td>
<td><%=resultSet.getString("departure_time") %></td>
<td><%=resultSet.getString("ac") %></td>
<td><%=resultSet.getDate("dt") %></td>
<td><%=resultSet.getInt("seat") %></td>
<td><%=resultSet.getString("total_amt") %></td>
<td><a href="cancel_ticket.jsp?id=<%=resultSet.getInt("trans_id") %>&amt=<%=resultSet.getInt("total_amt") %>&user=<%=resultSet.getString("username") %>">
        <button type="button" class="delete">Cancel Ticket</button></a></td>
</tr>
<%
    }while(resultSet.next());
}
else{
%><h1>No any booking</h1><%
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
