<%-- 
    Document   : EditRewards
    Created on : Jan 31, 2015, 8:43:51 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="members.Skill"%>
<%@page import="sql.QuestSaver"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Rewards...</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <%
            QuestLoader ql = new QuestLoader();
            CharacterLoader cl = new CharacterLoader();
            ql.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
            cl.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
            Quest quest = ql.getQuest(request.getParameter("questName"));
            quest.removeReward(request.getParameter("oldSkill"));
            if (!request.getParameter("skillName").equals("")) {
                quest.addReward(new Skill(request.getParameter("skillName")), Integer.valueOf(request.getParameter("EXP")));
            }
            QuestSaver saver = new QuestSaver(quest);
            saver.saveQuest();
        %>
        <script>
            window.location = "EditQuest.jsp?questName=<%=quest.getName()%>";
        </script>
    </body>
</html>
