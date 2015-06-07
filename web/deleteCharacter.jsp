<%-- 
    Document   : deleteCharacter
    Created on : Feb 1, 2015, 7:47:24 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.CharacterSaver"%>
<%@page import="sql.CharacterLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting character...</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <%
            CharacterLoader cl = new CharacterLoader();
            cl.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
            CharacterSaver cs = new CharacterSaver(cl.getMember(request.getParameter("characterName")));
            cs.deleteCharacter();
        %>
        <script>
            window.location = 'QuestBoard.jsp'
        </script>
    </body>
</html>
