<%-- 
    Document   : cancel_ticket_admin
    Created on : 23 Feb, 2021, 2:00:08 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%! public void setBalance(Connection con, String username,int bal) throws SQLException {

        String check = "update passenger set balance = "+bal+" where username = '" + username+"'";
        Statement stmt = con.createStatement();
        stmt.executeUpdate(check);
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
<%
String id=request.getParameter("id");
String user = request.getParameter("user");
int amt = Integer.parseInt(request.getParameter("amt"));
//double d_amt = (0.1)*amt;
//int ded_amt = (int)d_amt;
%>
                <script>
                    alert('Rs.<%=amt %> will be return!');
                </script>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
int bal = getBalance(conn,user);
setBalance(conn,user,bal+amt);
Statement st=conn.createStatement();
int i=st.executeUpdate("DELETE FROM reserve WHERE trans_id="+id);
%>
                <script>
                    alert('Ticket is canceled Successfully!');
                </script>
<%
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>
