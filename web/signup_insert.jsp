<%-- 
    Document   : signup_insert
    Created on : 12 Jan, 2021, 12:40:20 AM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*" %>
<%! public boolean isUserExist(Connection con,String uname)throws SQLException{
               
                String check = "select username from passenger where username = "+"'"+ uname +"'" ;
                Statement stmt=con.createStatement();  
                ResultSet r=stmt.executeQuery(check);
                return r.next();
                }
                
%>
<%

    String _username = request.getParameter("uname");
    String _password = request.getParameter("password");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    long phNum = Long.parseLong(request.getParameter("phNum"));


    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
        
        //checking user exist or not
//        String check = "select username from user_tb where username = "+"'"+ _username +"'" ;
//        Statement stmt=con.createStatement();  
//        ResultSet r=stmt.executeQuery(check);
        if(isUserExist(con,_username))
        {
            %>
            <script>
                alert('This username is already exist!!\ntry with different username');
                location = 'signup.html';
            </script>
            <%
        }
        else{
            
            //inserting data into db
            String query = "insert into passenger(username,password,name,email,mobile) values(?,?,?,?,?)";
            PreparedStatement psm = con.prepareStatement(query);
            psm.setString(1, _username);
            psm.setString(2, _password);
            psm.setString(3, name);
            psm.setString(4, email);
            psm.setLong(5, phNum);
            int rs = psm.executeUpdate();

            if (rs == 1) {
                session.setAttribute("sessname",_username);
                response.sendRedirect("user_panel.html");
            }   
        }
        
    } catch (Exception e) {
        out.println("Exception" + e.getMessage());
    }

%>
