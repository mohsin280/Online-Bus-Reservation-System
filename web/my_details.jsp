<%-- 
    Document   : my_details
    Created on : 16 Jan, 2021, 1:24:49 AM
    Author     : mohsi
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public ResultSet userDetails(Connection con,String username) throws SQLException {

        String check = " select * from bus_db.passenger where bus_db.passenger.username=" + "'" + username + "'";
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
            hr.dashed {
                border-top: 3px dashed #bbb;
            }
        </style>
    </head>
    <body>
        
<%
try{
String username = (session.getAttribute("sessname")).toString();
connection = DriverManager.getConnection(connectionUrl+database, userid, password);

resultSet = userDetails(connection, username);
if(resultSet.next()){
    
%>
<h1>User Details</h1>
<hr class="solid">
<h2>User Id: <%=resultSet.getInt("id") %></h2>
<h2>Username: <%=resultSet.getString("username") %></h2>
<h2>Password: <%=resultSet.getInt("password") %></h2>
<h2>Name: <%=resultSet.getString("name") %></h2>
<h2>Email Id: <%=resultSet.getString("email") %></h2>
<h2>Mobile no.: <%=resultSet.getString("mobile") %></h2>
<h2>Balance: Rs.<%=resultSet.getInt("balance") %></h2>
<%
}
else{
%><h1>User details is empty</h1><%
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

