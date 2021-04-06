<%-- 
    Document   : cancel_bus
    Created on : 23 Feb, 2021, 1:39:43 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%! public boolean isBookingAvailable(Connection con, int bus_id) throws SQLException {

        String check = "select * from reserve where bus_id = "+bus_id;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(check);
        return rs.next() ;
    }

%>
<%
int id=Integer.parseInt(request.getParameter("id"));
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
Statement st=conn.createStatement();
if(isBookingAvailable(conn,id))
{
    %>
                <script>
                    alert('This bus is already in booking\ncancel users tickets!');
                </script>
<%
}
else{
int i=st.executeUpdate("DELETE FROM bus WHERE bus_id = "+id);
%>
                <script>
                    alert('Bus canceled Successfully!');
                </script>
<%
    }
}
catch(Exception e)
{
out.println("Exception :"+e);
}
%>
