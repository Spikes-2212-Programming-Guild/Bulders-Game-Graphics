<%-- 
    Document   : EditSkillRequirement
    Created on : Jan 31, 2015, 7:55:10 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="members.Skill"%>
<%@page import="sql.QuestSaver"%>
<%@page import="quests.Quest"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Skill Requirement</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <%
            QuestLoader ql = new QuestLoader();
            CharacterLoader cl = new CharacterLoader();
            ql.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
            cl.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
            Quest quest = ql.getQuest(request.getParameter("questName"));
            quest.removeSkill(request.getParameter("oldSkill"));
            if (!request.getParameter("skillName").equals("") || !request.getParameter("level").equals("")) {
                quest.addSkillRequirment(new Skill(request.getParameter("skillName")), Integer.valueOf(request.getParameter("level")));
            }
            QuestSaver saver = new QuestSaver(quest);
            saver.saveQuest();
        %>
        <script>
            window.location = "EditQuest.jsp?questName=<%=quest.getName()%>";
        </script>
    </body>
</html>
