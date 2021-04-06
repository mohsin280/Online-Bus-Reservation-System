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
<%! public int getBalance(Connection con, String username) throws SQLException {

        String check = "select balance from passenger where username = '" + username+"'";
        Statement stmt = con.createStatement();
        ResultSet r = stmt.executeQuery(check);
        r.next();
        return r.getInt("balance");
    }

%>
<%! public void setBalance(Connection con, String username,int bal) throws SQLException {

        String check = "update passenger set balance = "+bal+" where username = '" + username+"'";
        Statement stmt = con.createStatement();
        stmt.executeUpdate(check);
    }

%>
<%! public int setReserve(Connection con, String uname,int bus_id,Date dt,int seat,int tot_amt) throws SQLException {

        String query = "insert into reserve(username,bus_id,dt,seat,total_amt) values(?,?,?,?,?)";
            PreparedStatement psm = con.prepareStatement(query);
            psm.setString(1, uname);
            psm.setInt(2, bus_id);
            psm.setDate(3, dt);
            psm.setInt(4, seat);
            psm.setInt(5, tot_amt);
            int n=psm.executeUpdate();
            return n;
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
String username=(session.getAttribute("sessname")).toString();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body><center>
        <%
try{
    int bus_id = Integer.parseInt(request.getParameter("bus_id"));
    int seat = Integer.parseInt(request.getParameter("seat"));
    String str = request.getParameter("date1");
    Date date=Date.valueOf(str);
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
resultSet = getBus(connection, bus_id);

if(resultSet.next()){
int amt=seat*(Integer.parseInt(resultSet.getString("fare")));

//String a = request.getParameter("emsg");
//    if(a != null){
//        setReserve(connection,1001,bus_id,date,seat,amt);
//    }
    
%>
        Transaction ID:<%=getTransId(connection) %><br>
        Bus ID:<%=bus_id %><br>
        Username:<%=username %><br>
        Date:<%=date %><br>
        Fare:<%=resultSet.getString("fare") %><br>
        Type:<%=resultSet.getString("ac") %><br>
        Total Seat:<%=seat%><br>
        Total amount:<%=amt%><br>
        
        <button id="demo" onclick="myFunction()">Confirm Booking</button>

<script>
function myFunction() {
  <%
      int bal = getBalance(connection,username);
      if(bal>=amt){
        setBalance(connection,username,bal-amt);  
        setReserve(connection,username,bus_id,date,seat,amt);
        %>
        alert("seat is succesfully booked!");
        location = 'search_ticket.html';
        <%  }
        else{ 

        %>
            alert("Insufficient Balance!\nAdd money to the wallet");
            location = 'search_ticket.html';
            <%
        }
        %>
}
</script>
       
        <%
            
}
else{
    
    %>
            <script>
                alert('This bus is not available');
                location = 'search_ticket.html';
            </script>
            <%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
out.println("Connection Exception" + e.getMessage());
}
%>
    </center></body>
</html>
