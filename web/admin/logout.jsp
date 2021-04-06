<%-- 
    Document   : logout
    Created on : 23 Feb, 2021, 2:58:30 PM
    Author     : mohsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
            session.invalidate();
            %>
            <script>
                window.close();
            </script>
<%
 %>