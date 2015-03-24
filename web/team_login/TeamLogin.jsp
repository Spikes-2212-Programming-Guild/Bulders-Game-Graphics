<%-- 
    Document   : TeamLogin
    Created on : Mar 23, 2015, 10:25:20 AM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.GurnyStaff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Team Login</title>
    </head>
    <body style="text-align: center">
        <input type="button" value="Register!" onclick="window.location = 'Register.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <h1>Welcome to this site!</h1>
        Please, login: <br/>
        <%
            if (request.getParameter("team_number") == null || request.getParameter("password") == null) {
        %>
        <form action="TeamLogin.jsp" method="post">
            <div style="position: relative; right: 25px">
                <div style="position: relative; right: 16px">
                    Team Number <input type="text" name="team_number" value="" size="15"/> <br/>
                </div>
                Password <input type="password" name="password" value="" size="15"/> <br/>
            </div>
            <input type="submit" value="Login" />
        </form>
        <%
            } else {
                GurnyStaff gurnyStaff = new GurnyStaff();
                if (gurnyStaff.select("select * from Teams where team_number=" + request.getParameter("team_number") + " and password = \"" + request.getParameter("password") + "\";").length > 0) {
                    session.setAttribute(constants.TEAM_NUMBER, Integer.valueOf(request.getParameter("team_number")));
                %>
                <script>
                    window.location =  '../QuestBoard.jsp'
                </script>
                <%
                }
            }
        %>
    </body>
</html>
