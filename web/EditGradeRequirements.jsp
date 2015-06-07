<%-- 
    Document   : EditGradeRequirements
    Created on : Feb 1, 2015, 6:08:59 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.QuestSaver"%>
<%@page import="members.Grade"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Grade Requirements...</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <%
            QuestLoader ql = new QuestLoader();
            ql.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
            Quest quest = ql.getQuest(request.getParameter("questName"));
            int gradeCount = Integer.valueOf(request.getParameter("gradeCount"));
            if (request.getParameter("gradeCount").equals("")) {
                gradeCount = 0;
            }
            if (gradeCount < 0) {
                gradeCount = 0;
            }
            quest.setGradeRequirement(Grade.valueOf(request.getParameter("gradeName")), gradeCount);
            QuestSaver saver = new QuestSaver(quest);
            saver.saveQuest();
        %>
        <script>
            window.location = "EditQuest.jsp?questName=<%=quest.getName()%>";
        </script>
    </body>
</html>
