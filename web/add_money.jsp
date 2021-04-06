<%-- 
    Document   : add_money
    Created on : 1 Feb, 2021, 1:32:02 AM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! public int getBalance(Connection con,String uname)throws SQLException{
               
                String check = "select balance from passenger where username = "+"'"+ uname +"'" ;
                Statement stmt=con.createStatement();  
                ResultSet r=stmt.executeQuery(check);
                r.next();
                return r.getInt(1);
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
<%
try{
    int amt = Integer.parseInt(request.getParameter("amt"));
    String user = session.getAttribute("sessname").toString();
    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
    int bal = getBalance(connection,user);
    %>
<%
    int tot = bal + amt ;
    String check = "update bus_db.passenger set balance = "+tot+" where username = '"+user+"' ";
    Statement stmt = connection.createStatement();
    stmt.executeUpdate(check);
connection.close();
%>
            <script>
                alert('Money is added\nYour account balance is <%=tot %>');
                location = 'add_money_panel.html';
            </script>
            <%
} catch (Exception e) {
e.printStackTrace();
out.println("Exception" + e.getMessage());
}
%>

