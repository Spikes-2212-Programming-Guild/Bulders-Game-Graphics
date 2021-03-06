<%-- 
    Document   : EditSkill
    Created on : Jan 31, 2015, 4:05:24 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.CharacterSaver"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="members.Member"%>
<%@page import="sql.GurnyStaff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Skill Editor</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <%! String character;
            String skillName;
            String oldSkill;
            int skillLevel;
            int skillEXP;%>
        <%
            character = request.getParameter("character");
            skillName = request.getParameter("skillName");
            oldSkill = request.getParameter("oldSkill");
            if (character != null && skillName != null && oldSkill != null && request.getParameter("skillLevel") != null && request.getParameter("skillEXP") != null) {
                if (skillName.equals("") || request.getParameter("skillLevel").equals("")) {
                    GurnyStaff gurnyStaff = new GurnyStaff();
                    CharacterLoader characterLoader = new CharacterLoader();
                    characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
                    gurnyStaff.insertUpdateDelete("delete from " + sql.CharacterSaver.getCharacterSkills(characterLoader.getMember(character)) + " where name=\"" + oldSkill + "\";");
                    characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
                } else {
                    skillLevel = Integer.valueOf(request.getParameter("skillLevel"));
                    if(request.getParameter("skillEXP").equals("")){
                        skillEXP = 0;
                    }
                    skillEXP = Integer.valueOf(request.getParameter("skillEXP"));
                    GurnyStaff gurnyStaff = new GurnyStaff();
                    CharacterLoader characterLoader = new CharacterLoader();
                    characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
                    gurnyStaff.insertUpdateDelete("delete from " + sql.CharacterSaver.getCharacterSkills(characterLoader.getMember(character)) + " where name=\"" + oldSkill + "\";");
                    characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
                    characterLoader.getMember(character).addSkill(skillName, skillLevel, skillEXP);
                    CharacterSaver cs = new CharacterSaver(characterLoader.getMember(character));
                    cs.saveCharacter();
                }
            }
        %>
        <script>
            window.location = "EditCharacter.jsp?character=<%=character%>";
        </script>
    </body>
</html>
