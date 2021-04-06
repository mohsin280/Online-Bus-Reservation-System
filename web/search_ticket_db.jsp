<%-- 
    Document   : search_ticket_db
    Created on : 10 Jan, 2021, 1:51:18 AM
    Author     : mohsi
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public ResultSet searchBus(Connection con, String from,String to) throws SQLException {

        String check = "select * from bus where origin = " + "'" + from + "' and destination = " + "'" + to + "'";
        Statement stmt = con.createStatement();
        ResultSet r = stmt.executeQuery(check);
        return r;
    }

%>
<%! public ResultSet availableSeat(Connection con, int id,Date d) throws SQLException {

        String check = "select sum(seat) from reserve where bus_id = " + "'" + id + "' and dt = " + "'" + d + "'";
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
ResultSet rsAvail = null;
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
              height: 30px;
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
        
<%
try{
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String str = request.getParameter("date");
    Date date=Date.valueOf(str);
connection = DriverManager.getConnection(connectionUrl+database, userid, password);

resultSet = searchBus(connection, from, to);
if(resultSet.next()){
    rsAvail=availableSeat(connection,Integer.parseInt(resultSet.getString("bus_id")),date);
    int sumcount=45;
    if(rsAvail.next())
    {
        sumcount -=rsAvail.getInt(1);
    }
%>
<h1>Available Buses</h1>
Date:<%=date %>
<table border="1">
<tr>
<th>Bus ID</th>
<th>origin</th>
<th>Destination</th>
<th>Arrival Time</th>
<th>Departure Time</th>
<th>AC/Non-Ac</th>
<th>Fare</th>
<th>Available Seat</th>
</tr>
<tr>
<td><%=resultSet.getString("bus_id") %></td>
<td><%=resultSet.getString("origin") %></td>
<td><%=resultSet.getString("destination") %></td>
<td><%=resultSet.getString("arrival_time") %></td>
<td><%=resultSet.getString("departure_time") %></td>
<td><%=resultSet.getString("ac") %></td>
<td><%=resultSet.getString("fare") %></td>
<td><%=sumcount %></td>
</tr>
<%
while(resultSet.next()){
    rsAvail=availableSeat(connection,Integer.parseInt(resultSet.getString("bus_id")),date);
    int sumcount1=45;
    if(rsAvail.next())
    {
        sumcount1 -=rsAvail.getInt(1);
    }
%>
<tr>
<td><%=resultSet.getString("bus_id") %></td>
<td><%=resultSet.getString("origin") %></td>
<td><%=resultSet.getString("destination") %></td>
<td><%=resultSet.getString("arrival_time") %></td>
<td><%=resultSet.getString("departure_time") %></td>
<td><%=resultSet.getString("ac") %></td>
<td><%=resultSet.getString("fare") %></td>
<td><%=sumcount1 %></td>
</tr>
<%
}
}
else{
%><h1>No bus available</h1><%
}

connection.close();
} catch (Exception e) {
e.printStackTrace();
out.println("Exception" + e.getMessage());
}
%>
</table>
    </body>
</html>
