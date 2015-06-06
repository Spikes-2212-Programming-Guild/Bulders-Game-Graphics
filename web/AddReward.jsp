<%-- 
    Document   : AddReward
    Created on : Jan 31, 2015, 8:49:49 PM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="members.Skill"%>
<%@page import="sql.QuestSaver"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>It's All About the Money</title>
    </head>
    <body>
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <%!String questName;
            String skillName;%>
        <%questName = request.getParameter("questName");
            skillName = request.getParameter("skillName"); %>
        <%if (questName == null) {%>
        <h1 style="text-align: center">Choose Your Quest...</h1>
        <form method="post" action="AddReward.jsp">
            <select name="questName" style="font-size: larger">
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
        <%} else if (skillName == null) {%>
        <h1 style="text-align: center">It's all about the money of: <%=questName%></h1>
        <form action="AddReward.jsp" method="post">
            <input type="hidden" name="questName" value="<%=questName%>"/> 
            <input type="text" name="skillName" value="Enter skill name..." id="name" onfocus="document.getElementById('name').value = ''"/> <br/>
            <input type="number" name="EXP" value="0"/> <br/>
            <input type="submit" value="Ca$h Money!" />
        </form>
        <%
        } else {
            QuestLoader questLoader = new QuestLoader();
            questLoader.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
            for (Quest q : questLoader.getQuests()) {
                if (q.getName().equalsIgnoreCase(questName)) {
                    q.addReward(new Skill(skillName), Integer.valueOf(request.getParameter("EXP")));
                    QuestSaver qs = new QuestSaver(q);
                    qs.saveQuest();
                }
            }%>
        <h1 style="text-align: center">Added reward!</h1>  
        <form method = "post" action="AddReward.jsp">
            <input type="hidden" name="quest" value="<%=questName%>" />
            <input type="submit" value="Add Another Requirement!" />
            <input type="button" value="Choose another quest!" onclick="window.location = 'AddReward.jsp'"/>
            <input type="button" value="Go to editing..." onclick="window.location = 'EditQuest.jsp?questName=<%=questName%>'"
        </form>
        <%}%>
    </body>
</html>
