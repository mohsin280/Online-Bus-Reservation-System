<%-- 
    Document   : book_ticket_db
    Created on : 11 Jan, 2021, 1:17:00 AM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public int getTransId(Connection con) throws SQLException {

        String check = "select max(trans_id) from reserve";
        Statement stmt = con.createStatement();
        ResultSet r = stmt.executeQuery(check);
        if(r.next())
            return r.getInt(1)+1;
        else
            return 0;
    }

%>
<%! public ResultSet getBus(Connection con, int id) throws SQLException {

        String check = "select * from bus where bus_id = " + id ;
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
out.println("Class Not found Exception " + e.getMessage());
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
    </head>
    <body>
        <%
try{
    int bus_id = Integer.parseInt(request.getParameter("bus_id"));
    int seat = Integer.parseInt(request.getParameter("seat"));
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
resultSet = getBus(connection, bus_id);
if(resultSet.next()){
int amt=seat*(Integer.parseInt(resultSet.getString("fare")));
%>
        Transaction ID:<%=getTransId(connection) %><br>
        Bus ID:<%=bus_id %><br>
        Fare:<%=resultSet.getString("fare") %><br>
        Type:<%=resultSet.getString("ac") %><br>
        Total Seat:<%=seat%><br>
        Total amount:<%=amt%><br>
        <%
}
else{
    out.println("Not found");
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
out.println("Connection Exception" + e.getMessage());
}
%>
    </body>
</html>
