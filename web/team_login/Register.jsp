<%-- 
    Document   : Register
    Created on : Mar 24, 2015, 2:49:38 PM
    Author     : thinkredstone
--%>

<%@page import="java.util.Random"%>
<%@page import="sql.constants"%>
<%@page import="sql.GurnyStaff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <script src="../Javascript/validateInput.js"></script>
    </head>
    <body style="text-align: center">
        <h1>Enter Team Name, Team number and Password:</h1>
        <form action="Register.jsp" method="post" onsubmit="return validateNumbers(document.getElementById('number').value)">
            <div style="position: relative; right: 25px">
                <div style="position: relative; right: 9px">
                    Team Name <input type="text" name="team_name" value="" size="15" id="name"/> <br/>
                </div>
                <div style="position: relative; right: 16px">
                    Team Number <input type="text" name="team_number" value="" size="15" id="number"/> <br/>
                </div>
                Password <input type="password" name="password" value="" size="15"/> <br/>
            </div>
            <input type="submit" value="Register" /> <br/>
        </form>
        <%
            if (request.getParameter("team_number") != null && request.getParameter("password") != null && request.getParameter("team_name") != null) {
                GurnyStaff gurnyStaff = new GurnyStaff();
                if (gurnyStaff.select("select * from Teams where team_number=" + request.getParameter("team_number") + ";").length > 0) {
                    out.println("That team is already registered, you cheeky little hacker!");
                } else {//65 -122
                    Random r = new Random();
                    String salt = "";
                    String alphabet = "qwertyuiopasdfghjklzxcvbnm";
                    for (int i = 0; i < 16; i++) {
                        salt += (alphabet.charAt(r.nextInt(alphabet.length())));
                    }
                    int hash = (request.getParameter("password") + salt).hashCode();
                    gurnyStaff.insertUpdateDelete("INSERT INTO Teams (team_number, password, team_name, salt) VALUES (" + request.getParameter("team_number") + ", '" + hash + "', '" + request.getParameter("team_name").replaceAll("<", "&lt;") + "', '" + salt + "');");
                    session.setAttribute(constants.TEAM_NUMBER, Integer.valueOf(request.getParameter("team_number")));
        %>
        <script>
            window.location = "../QuestBoard.jsp";
        </script>
        <%
                }
            }
        %>
    </body>
</html>
