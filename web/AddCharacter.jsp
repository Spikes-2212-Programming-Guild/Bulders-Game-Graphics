<%-- 
    Document   : AddCharacter
    Created on : Jan 27, 2015, 5:39:25 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.CharacterSaver"%>
<%@page import="members.Grade"%>
<%@page import="members.Member"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add a Character</title>
    </head>
    <body>
        <%!
            String name;
            int grade;
        %>
        <%
            if (request.getParameter("name") != null && request.getParameter("grade") != null) {
                name = request.getParameter("name");
                grade = Integer.valueOf(request.getParameter("grade"));
        %>
        <div style="text-align: center;font-size: larger">
            Saving character! <br/>
        </div>
        <%
            boolean nameIsValid = true;
            for (String s : constants.INVALID_NAMES) {
                if (s.equalsIgnoreCase(name)) {
                    out.print("Invalid name!");
                    nameIsValid = false;
                    break;
                }
            }
            if (nameIsValid) {
                Member m;
                switch (grade) {
                    case 5:
                        m = new Member(Grade.FIFTH, name);
                        break;
                    case 7:
                        m = new Member(Grade.SEVENTH, name);
                        break;
                    case 8:
                        m = new Member(Grade.EIGHTH, name);
                        break;
                    default:
                        m = null;
                        out.print("Problem saving character...");
                }
                CharacterSaver characterSaver = new CharacterSaver(m);
                characterSaver.saveCharacter();
        %>
        <div style="text-align: center;font-size: larger">
            Character Saved! <br/>
            Redirecting to skill management... <br/>
        </div>
        <script>
            setTimeout(function () {
                window.location = "AddSkillToCharacter.jsp"
            }, 1000);
        </script>
        <%            }
        } else {
        %>
        <h1 style="text-align: center">
            Create a Character!
        </h1> <br/>
        <form action="AddCharacter.jsp" method="post">
            Name: <input type="text" name="name" id="name" value="Enter a name" onfocus="document.getElementById('name').value = ''"/> <br/>
            Grade: <select name="grade">
                <option value="5">Fifth</option>
                <option value="7">Seventh</option>
                <option value="8">Eighth</option>
            </select> <br/>
            <input type="submit" value="Create!" name="submit" />
        </form>
        <%}%>
    </body>
</html>
