<%-- 
    Document   : EditCharacter
    Created on : Jan 31, 2015, 3:21:31 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="members.Skill"%>
<%@page import="members.Member"%>
<%@page import="sql.CharacterLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Character Editor</title>
    </head>
    <body>
        <%! String character;%>
        <%! Member member;%>
        <%
            character = request.getParameter("character");
            if (character != null) {
                CharacterLoader characterLoader = new CharacterLoader();
                characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
                member = characterLoader.getMember(character);
        %>
        <h1 style="text-align: center">Currently Playing with the Life of: <%=character%></h1> 
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <br/>
        <h2>Grade: <%=member.getGrade()%></h2> 
        <h2>Skills: </h2> 
        <table  style="width: 50%;">
            <tr>
                <td>Name</td>
                <td>Level</td>
                <td>EXP</td>
            </tr>
            <%
                for (Skill s : member.getSkills()) {
            %>
            <tr>
            <form action="EditSkill.jsp">
                <input type="hidden" value="<%=character%>" name="character"/>
                <input type="hidden" value="<%=s.getName()%>" name="oldSkill"/>
                <td><input type="text" value="<%=s.getName()%>" name="skillName"/></td>
                <td><input type="text" value="<%=s.getLevel()%>" name="skillLevel"/></td>
                <td><input type="text" value="<%=s.getExp()%>" name="skillEXP"/></td>
                <td><input type="submit" value="Commit this line!"></td>
            </form>
        </tr>
        <%
            }%>
    </table>
    <input type="submit" value="Add Skill" onclick="window.location = 'AddSkillToCharacter.jsp?character=<%=character%> '"/>
    <form method="post" action="deleteCharacter.jsp">
        <input type="hidden" name="characterName" value="<%=character%>"/>
        <input type="submit" value="Finish him!" style="position: relative;left: 50%; top: 30px"/>
    </form>
    <%
    } else {
    %>
    <h1>Select a character:</h1> <br/>
    <form method="post" action="EditCharacter.jsp">
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
        }
    %>

</body>
</html>
