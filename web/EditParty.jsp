<%-- 
    Document   : EditParty
    Created on : Jan 31, 2015, 6:45:45 PM
    Author     : thinkredstone
--%>

<%@page import="sql.QuestSaver"%>
<%@page import="quests.Quest"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Party</title>
    </head>
    <body>
        <%
            QuestLoader ql = new QuestLoader();
            CharacterLoader cl = new CharacterLoader();
            ql.readQuests();
            cl.readCharacters();
            Quest quest = ql.getQuest(request.getParameter("quest"));
            quest.removeMember(request.getParameter("oldCharacter"));
            quest.addMember(cl.getMember(request.getParameter("character")));
            QuestSaver saver = new QuestSaver(quest);
            saver.saveQuest();
        %>
        <script>
            window.location = "EditQuest.jsp?questName=<%=quest.getName()%>";
        </script>
    </body>
</html>
