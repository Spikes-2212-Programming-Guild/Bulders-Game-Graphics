<%-- 
    Document   : QuestBoard
    Created on : Jan 31, 2015, 12:01:24 PM
    Author     : thinkredstone
--%>

<%@page import="quests.PartyBuilder"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="members.Member"%>
<%@page import="quests.Quest"%>
<%@page import="sql.QuestLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>!</title>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;font-size: larger">
        <h1 style="text-align: center;">Quest Board</h1>
        <%
            QuestLoader questLoader = new QuestLoader();
            questLoader.readQuests();
            CharacterLoader characterLoader = new CharacterLoader();
            characterLoader.readCharacters();
            if (request.getParameter("quest") != null) {
                Set<Member> availableCharacters = new HashSet<>();
                for (Member m : characterLoader.getCharacters()) {
                    if (request.getParameter(m.getName()) != null) {
                        availableCharacters.add(m);
                    }
                }
                PartyBuilder partyBuilder = new PartyBuilder(questLoader.getQuest(request.getParameter("quest")), availableCharacters);
                partyBuilder.buildParty();
            }
        %>
        <form action="QuestBoard.jsp">
            <table style="width: 100%">
                <tr>
                    <td>
                        <table style="width: 50%;">
                            <tr>
                            <tr>
                                <td>Quest Name</td>
                                <td>Current Party</td>
                                <td>Assign Party</td>
                            </tr>
                            <%
                                for (Quest q : questLoader.getQuests()) {
                            %>
                            <tr>
                                <td><%=q.getName()%></td>
                                <td>
                                    <%
                                        for (Member m : q.getParty()) {
                                            out.print(m.getName() + " ");
                                        }
                                    %>
                                </td>
                                <td>
                                    <input type="submit" value="Blank" id="<%=q.getName()%>" name="quest" onclick="document.getElementById('<%=q.getName()%>').value = '<%=q.getName()%>'"/>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </table></td>
                    <td>
                        <table style="width: 50%;position: relative;right: 50%;">
                            <tr>
                                <td>Character Name</td>
                                <td>Present</td>
                            </tr>
                            <%
                                for (Member m : characterLoader.getCharacters()) {
                            %>
                            <tr>
                                <td><%=m.getName()%></td>
                                <td><input type="checkbox" name="<%=m.getName()%>" value="<%=m.getName()%>" <%=request.getParameter("checkAll")%>/></td>
                            </tr>
                            <%
                                }
                            %>
                            <tr>
                                <td>
                                    <form>
                                        <input value="Uncheck All" type="submit"/>
                                    </form>
                                </td>
                                <td>
                                    <form action="QuestBoard.jsp">
                                        <input name="checkAll" value="checked" type="hidden"/>
                                        <input value="Check All" type="submit"/>
                                    </form>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>