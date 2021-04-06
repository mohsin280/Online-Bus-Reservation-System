<%-- 
    Document   : user_home
    Created on : 19 Jan, 2021, 2:53:48 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
                background-image: url("images/bus3.jpg");
                height: 100%;

  /* Center and scale the image nicely */
  background-position: inherit;
  background-repeat: no-repeat;
  background-size: cover;
            }
        </style>
    </head>
    <body>
        <%
            String user = session.getAttribute("sessname").toString();
        %>
        <h1 style="text-align: center">User Panel</h1>
        <marquee style="color:rgb(255, 255, 255); font-size: 60px;">Welcome,<%= user %></marquee>
    </body>
</html>
