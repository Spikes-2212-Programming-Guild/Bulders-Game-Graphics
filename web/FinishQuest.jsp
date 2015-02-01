<%-- 
    Document   : FinishQuest
    Created on : Feb 1, 2015, 6:46:01 PM
    Author     : thinkredstone
--%>

<%@page import="sql.QuestSaver"%>
<%@page import="sql.CharacterSaver"%>
<%@page import="members.Skill"%>
<%@page import="java.util.Map"%>
<%@page import="members.Member"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Finishing Quest...</title>
    </head>
    <body>
        <%
            QuestLoader ql = new QuestLoader();
            ql.readQuests();
            CharacterSaver cs;
            Quest quest = ql.getQuest(request.getParameter("questName"));
            for (Member m : quest.getParty()) {
                   for(Map.Entry<Skill,Integer> exp : quest.getRewards().entrySet()){
                       m.addExp(exp.getKey().getName(), exp.getValue());
                   }
                   cs = new CharacterSaver(m);
                   cs.saveCharacter();
            }
            QuestSaver qs = new QuestSaver(quest);
            qs.deleteQuest();
        %>
    </body>
</html>
