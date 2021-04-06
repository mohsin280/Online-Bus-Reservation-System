<%-- 
    Document   : logout
    Created on : 11 Jan, 2021, 9:26:13 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
            session.invalidate();
            response.sendRedirect("index.html");
 %>
