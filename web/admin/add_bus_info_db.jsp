<%-- 
    Document   : add_bus_info_db
    Created on : 23 Feb, 2021, 12:44:01 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*" %>
<%! public boolean isUserExist(Connection con,int bus_id)throws SQLException{
               
                String check = "select bus_id from bus where bus_id = "+bus_id ;
                Statement stmt=con.createStatement();  
                ResultSet r=stmt.executeQuery(check);
                return r.next();
                }
                
%>
<%

    int bus_id = Integer.parseInt(request.getParameter("bus_id"));
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String arrival = request.getParameter("arrival");
    String dept = request.getParameter("dept");
    String type = request.getParameter("type");
    int fare = Integer.parseInt(request.getParameter("fare"));

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
        
        //checking user exist or not
//        String check = "select username from user_tb where username = "+"'"+ _username +"'" ;
//        Statement stmt=con.createStatement();  
//        ResultSet r=stmt.executeQuery(check);
        if(isUserExist(con,bus_id))
        {
            %>
            <script>
                alert('This bus_id is already exist!!\ntry with different username');
                location = 'add_bus_info.html';
            </script>
            <%
        }
        else{
            
            //inserting data into db
            String query = "insert into bus(bus_id,origin,destination,departure_time,arrival_time,ac,fare) values(?,?,?,?,?,?,?)";
            PreparedStatement psm = con.prepareStatement(query);
            psm.setInt(1, bus_id);
            psm.setString(2, from);
            psm.setString(3, to);
            psm.setString(4, dept);
            psm.setString(5, arrival);
            psm.setString(6, type);
            psm.setInt(7, fare);
            int rs = psm.executeUpdate();

            if (rs == 1) {
                %>
            <script>
                alert('Bus information is successfully added');
                location = 'add_bus_info.html';
            </script>
            <%
                
            }   
        }
        
    } catch (Exception e) {
        out.println("Exception" + e.getMessage());
    }

%>
