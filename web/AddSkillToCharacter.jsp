<%-- 
    Document   : AddSkillToCharacter
    Created on : Jan 27, 2015, 8:06:52 PM
    Author     : thinkredstone
--%>

<%@page import="sql.CharacterSaver"%>
<%@page import="members.Member"%>
<%@page import="sql.CharacterLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Skill Adder 9000</title>
    </head>
    <body style="text-align: center">
        <%! String character;%>
        <%
            if (request.getParameter("character") == null) {
        %>
        <h1>Select a character:</h1>
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/><br/>
        <form method="post" action="AddSkillToCharacter.jsp">
            <select name="character" style="font-size: larger">
                <%
                    CharacterLoader characterLoader = new CharacterLoader();
                    characterLoader.readCharacters();
                    for (Member m : characterLoader.getCharacters()) {
                %>
                <option value="<%=m.getName()%>"><%=m.getName()%></option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="I choose you!" style="font-size: larger"/>
        </form>
        <%
        } else if (request.getParameter("skillName") == null && request.getParameter("skillLevel") == null && request.getParameter("skillEXP") == null) {
            character = request.getParameter("character");
        %>
        <h1>Selected Character: <%=character%></h1> <br/>
        <form method="post" action="AddSkillToCharacter.jsp" style="text-align: left">
            <h3>Add a skill:</h3> <br/>
            <input type="hidden" name="character" value="<%=character%>"/>
            Enter skill name:  <input type="text" name="skillName" value="Enter skill name..." id="name" onfocus="document.getElementById('name').value = ''"/> <br/>
            Enter skill level: <input type="number" name="skillLevel" value="1"/> <br/>
            Enter initial EXP: <input type="number" name="skillEXP" value="0"/> <br/>
            <input type="submit" value="new skill = true" />
        </form>
        <%
        } else {
            character = request.getParameter("character");
            CharacterLoader characterLoader = new CharacterLoader();
            characterLoader.readCharacters();
            for (Member m : characterLoader.getCharacters()) {
                if (m.getName().equalsIgnoreCase(character)) {
                    m.addSkill(request.getParameter("skillName"), Integer.valueOf(request.getParameter("skillLevel")), Integer.valueOf(request.getParameter("skillEXP")));
                    CharacterSaver characterSaver = new CharacterSaver(m);
                    characterSaver.saveCharacter();
        %>
        <h1>Added skill!</h1> <br/>
        <form method = "post">
            <input type="hidden" name="character" value="<%= character%>" />
            <input type="submit" value="Add Another!" />
        </form>
        <input type="submit" value="Choose another character!" onclick="window.location = 'AddSkillToCharacter.jsp'">
        <%
                    }
                }
            }
        %>
    </body>
</html>
