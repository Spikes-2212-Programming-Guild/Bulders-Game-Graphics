<%-- 
    Document   : AddSkillRequirmentToQuest
    Created on : Jan 31, 2015, 10:57:25 AM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.QuestSaver"%>
<%@page import="members.Skill"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lelouch</title>
    </head>
    <body>
        <%!
            String quest;
            String skill;
        %>
        <%quest = request.getParameter("quest");
            skill = request.getParameter("skill");
        %>
        <%
            if (quest == null) {
        %>
        <h1>Choose Your Quest...</h1>
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/><br/>
        <form method="post" action="AddSkillRequirementToQuest.jsp">
            <select name="quest" style="font-size: larger">
                <%
                    QuestLoader questLoader = new QuestLoader();
                    questLoader.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
                    for (Quest q : questLoader.getQuests()) {
                %>
                <option value="<%=q.getName()%>"><%=q.getName()%></option>
                <%
                    }
                %>
            </select> 
            <input type="submit" value="Vanguard, advance!" />
        </form>
        <%
        } else if (skill == null) {
        %>
        <h1 style="text-align: center">Choose <del>Arbitrary</del> FAIR Skill Requirements</h1>
        <form method="post" action="AddSkillRequirementToQuest.jsp">
            <input type="hidden" value="<%=quest%>" name="quest" />
            Enter skill name: <input type="text" name="skill" value="Enter Skill name..." id='name' onfocus="document.getElementById('name').value = ''"/> <br/>
            Enter Required Level: <input type="number" name="level" value="1" /> <br/>
            <input type="submit" value="To Battle!" />
        </form>
        <%
        } else {
            QuestLoader questLoader = new QuestLoader();
            questLoader.readQuests();
            for (Quest q : questLoader.getQuests()) {
                if (q.getName().equalsIgnoreCase(quest)) {
                    q.addSkillRequirment(new Skill(skill), Integer.valueOf(request.getParameter("level")));
                    QuestSaver qs = new QuestSaver(q);
                    qs.saveQuest();
        %>
        <h1>Added skill!</h1> 
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/><br/>
        <form method = "post" action="AddSkillRequirementToQuest.jsp">
            <input type="hidden" name="quest" value="<%= quest%>" />
            <input type="submit" value="Add Another Requirement!" />
            <input type="button" value="Choose another quest!" onclick="window.location = 'AddSkillRequirementToQuest.jsp'"/>
            <input type="button" value="Move to editing" onclick="window.location = 'EditQuest.jsp?questName=<%=quest%>'"/>
        </form>
        <%
                    }
                }
            }
        %>
    </body>
</html>
