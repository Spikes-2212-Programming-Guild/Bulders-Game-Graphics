<%-- 
    Document   : EditQuest
    Created on : Jan 31, 2015, 6:17:08 PM
    Author     : thinkredstone
--%>

<%@page import="java.util.Map"%>
<%@page import="members.Skill"%>
<%@page import="sql.CharacterLoader"%>
<%@page import="members.Member"%>
<%@page import="sql.QuestLoader"%>
<%@page import="quests.Quest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edith Thy Quest!</title>
    </head>
    <body>
        <%! String questName;%>
        <%! Quest quest;%>
        <%
            questName = request.getParameter("questName");
            if (questName == null) {
        %>
        <h1>Select a quest:</h1> 
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/><br/>
        <form method="post" action="EditQuest.jsp">
            <select name="questName" style="font-size: larger">
                <%
                    QuestLoader ql = new QuestLoader();
                    ql.readQuests();
                    for (Quest q : ql.getQuests()) {
                %>
                <option value="<%=q.getName()%>"><%=q.getName()%></option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="I choose you!" style="font-size: larger"/>
        </form><%
        } else {
            QuestLoader questLoader = new QuestLoader();
            questLoader.readQuests();
            quest = questLoader.getQuest(questName);
            CharacterLoader cl = new CharacterLoader();
            cl.readCharacters();
        %>
        <h1>Editing an Annoyance Named: <%=questName%></h1>
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <table style="width: 100%">
            <tr>
                <td>
                    <table>
                        <caption>Skill Requirement</caption>
                        <tr>
                            <td>Skill</td>
                            <td>Level</td>
                            <td><input type="button" value="Add Skill" onclick="window.location = 'AddSkillRequirementToQuest.jsp?quest=<%=questName%>'"></td>
                        </tr>

                        <%for (Map.Entry<Skill, Integer> entry : quest.getSkillRequirments().entrySet()) {%>
                        <tr>
                        <form action="EditSkillRequirement.jsp">
                            <input type="hidden" value="<%=questName%>" name="questName"/> 
                            <input type="hidden" value="<%=entry.getKey().getName()%>" name="oldSkill"/>
                            <td><input type="text" value="<%=entry.getKey().getName()%>" name="skillName"/></td>
                            <td><input type="number" value="<%=entry.getValue()%>"name="level"/></td>
                            <td><input type="submit" value="Commit Line"</td>
                            </tr>
                        </form>

                        <%}%>
                    </table>
                </td>
                <td>
                    <table>
                        <caption>Grade Requirement</caption>

                    </table>
                </td>
                <td>
                    <table>
                        <caption>Rewards</caption>
                        <tr>
                            <td>Skill</td>
                            <td>EXP</td>
                            <td><input type="button" onclick="window.location = 'AddReward.jsp?questName=<%=questName%>'" value="Add Rewards"/></td>
                        </tr>
                        <%for (Map.Entry<Skill, Integer> entry : quest.getRewards().entrySet()) {%>
                        <tr>
                        <form action="EditRewards.jsp">
                            <input type="hidden" value="<%=questName%>" name="questName"/> 
                            <input type="hidden" value="<%=entry.getKey().getName()%>" name="oldSkill"/>
                            <td><input type="text" value="<%=entry.getKey().getName()%>" name="skillName"/></td>
                            <td><input type="number" value="<%=entry.getValue()%>"name="EXP"/></td>
                            <td><input type="submit" value="Commit Line"</td>
                            </tr>
                        </form>
                        <%}%>
                    </table>
                </td>
                <td>
                    <table>
                        <caption>Current Party</caption>
                        <% for (Member m : quest.getParty()) {%>
                        <form action="EditParty.jsp">
                            <input type="hidden" value="<%=m.getName()%>" name="oldCharacter"/>
                            <input type="hidden" name="quest" value="<%=quest.getName()%>" />
                            <tr>
                                <td>
                                    <select name="character">
                                        <% for (Member member : cl.getCharacters()) {
                                                if (member.getName().equals(m.getName())) {
                                        %>
                                        <option selected="" value="<%=member.getName()%>"><%=member.getName()%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=member.getName()%>"><%=member.getName()%></option>
                                        <%}
                                            }%>
                                    </select>
                                </td>
                                <td>
                                    <input type="submit" value="Commit change" />
                                </td>
                            </tr>
                        </form>
                        <% }%>
                    </table>
                </td>
            </tr>
        </table>
        <%}%>
    </body>
</html>
