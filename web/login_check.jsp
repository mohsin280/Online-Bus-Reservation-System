<%-- 
    Document   : login_check
    Created on : 11 Jan, 2021, 8:00:39 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*" %>
<%

    String _username = request.getParameter("uname");
    String _password = request.getParameter("password");
    String role = request.getParameter("role");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bus_db", "mohsin", "7009");
        if (role.equals("admin")) {
            if (_username.equals("admin") && _password.equals("admin")) {
                session.setAttribute("sessname", _username);
                response.sendRedirect("admin/admin_panel.html");
            } else {
%>
                <script>
                    alert('Wrong Username or Password!!');
                    location = 'login.html';
                </script>
<%
            }
        } else {
                String query = "select * from passenger where username = ? and password = ?";
                PreparedStatement psm = con.prepareStatement(query);
                psm.setString(1, _username);
                psm.setString(2, _password);
                ResultSet rs = psm.executeQuery();

                if (rs.next()) {
                    session.setAttribute("sessname", _username);
                    response.sendRedirect("user_panel.html");
                } else {
            %>
            <script>
                alert('Wrong Username or Password!!');
                location = 'login.html';
            </script>
            <%
                        }
                 }

        } catch (Exception e) {
            out.println("Exception" + e.getMessage());
        }

%>
