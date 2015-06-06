<%-- 
    Document   : QuestBoard
    Created on : Jan 31, 2015, 12:01:24 PM
    Author     : thinkredstone
--%>

<%@page import="sql.GurnyStaff"%>
<%@page import="sql.constants"%>
<%@page import="sql.QuestSaver"%>
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
        <%
            System.out.println("was in QuestBoard");
            if (session.getAttribute(constants.TEAM_NUMBER) == null) {
        %>
        <script>
            window.location = "team_login/TeamLogin.jsp"
        </script>
        <%
        } else {
        %>
        <%! GurnyStaff gurnyStaff;%>
        <%
            gurnyStaff = new GurnyStaff();
            gurnyStaff.prepareSelectStatement("select * from Teams where team_number = ?;");
            gurnyStaff.prepareStatement().setInt(1, (int) session.getAttribute(constants.TEAM_NUMBER));
        %>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;font-size: larger">
        <input type="button" value="Logout!" onclick="window.location = 'team_login/TeamLogin.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <h1 style="text-align: center;">Quest Board for <%= gurnyStaff.executeSelect()[0][2]%></h1>
        <%
            QuestLoader questLoader = new QuestLoader();
            questLoader.readQuests((int) session.getAttribute(constants.TEAM_NUMBER));
            CharacterLoader characterLoader = new CharacterLoader();
            characterLoader.readCharacters((int) session.getAttribute(constants.TEAM_NUMBER));
            if (request.getParameter("quest") != null) {
                Set<Member> availableCharacters = new HashSet<>();
                for (Member m : characterLoader.getCharacters()) {
                    if (request.getParameter(m.getName()) != null) {
                        availableCharacters.add(m);
                    }
                }
                PartyBuilder partyBuilder = new PartyBuilder(questLoader.getQuest(request.getParameter("quest")), availableCharacters);
                partyBuilder.buildParty();
                QuestSaver qs = new QuestSaver(questLoader.getQuest(request.getParameter("quest")));
                qs.saveQuest();
            }
        %>
        <form action="QuestBoard.jsp">
            <table style="width: 100%">
                <tr>
                    <td>
                        <table style="width: 40%;">
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
                                <td><a style="color: whitesmoke;" href="EditQuest.jsp?questName=<%=q.getName()%>"><%=q.getName()%></a></td>
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
                        <table style="width: 40%;position: relative;right: 66%;">
                            <tr>
                                <td>Character Name</td>
                                <td>Present</td>
                            </tr>
                            <%
                                for (Member m : characterLoader.getCharacters()) {
                            %>
                            <tr>
                                <td><a style="color: whitesmoke;" href="EditCharacter.jsp?character=<%=m.getName()%>"><%=m.getName()%></a></td>
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
                    <td>
                        <input type="button" value="Add Character" onclick="window.location = 'AddCharacter.jsp'"/> <br/>
                        <input type="button" value="Add Quest" onclick="window.location = 'AddQuest.jsp'"/> <br/>
                    </td>
                </tr>
            </table>
        </form>
    </body>
    <%}%>
</html>
