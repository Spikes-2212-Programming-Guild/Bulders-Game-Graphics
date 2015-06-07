<%-- 
    Document   : AddQuest
    Created on : Jan 31, 2015, 9:52:29 AM
    Author     : thinkredstone
--%>

<%@page import="sql.constants"%>
<%@page import="sql.QuestSaver"%>
<%@page import="members.Grade"%>
<%@page import="quests.Quest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Art thou prepared?</title>
        <script src="Javascript/validateInput.js"></script>
    </head>
    <body style="background-image: url('wood.jpg');color: whitesmoke;">
        <input type="button" value="Press L!" onclick="window.location = 'QuestBoard.jsp'" style="position: absolute;right: 20px;top: 30px"/>
        <%!
            String name;
            int grade5;
            int grade7;
            int grade8;
        %>
        <%
            name = request.getParameter("name");
        %>
        <%
            if (name == null) {
        %>
        <h1 style="text-align: center">
            Make a <del>Needless Grinding Task</del> Quest!
        </h1>
        <form action="AddQuest.jsp" method="post" onsubmit="return validate(document.getElementById('name').value)">
            Name: <input type="text" name="name" id="name" value="Enter a name" onfocus="document.getElementById('name').value = ''"/> <br/>
            <input type="submit" value="Move to Requirments!" name="submit" />
        </form>
        <%
        } else if (request.getParameter("grade5") == null) {
        %>
        <h1 style="text-align: center">Choose <del>Size</del> GRADE Requirements!</h1> <br/>
        <form method ="post" onsubmit="return (validateNumbers(document.getElementById('grade5').value) && validateNumbers(document.getElementById('grade7').value) && validateNumbers(document.getElementById('grade8').value))" action="AddQuest.jsp" id="requirements">
            <input type="hidden" name="name" value="<%=name%>"/>
            Grade Requirements: 
            <input type="submit" style="position: relative; left: 120px; top: 43px" value="Choose Your Just Rewards!"/> <br/>
            FIFTH: <input type="number" name="grade5" value="0" id="grade5" style="position: relative; left: 28px" /> <br/>
            SEVENTH: <input type="number" name="grade7" value="0" id="grade7"/> <br/>
            EIGHTH: <input type="number" name="grade8" value="0" id="grade8" style="position: relative; left: 13px"/> <br/>
        </form>
        <%
        } else {
            boolean nameIsValid = true;
            for (String s : constants.INVALID_NAMES) {
                if (s.equalsIgnoreCase(name)) {
                    out.print("Invalid name!");
                    nameIsValid = false;
                    break;
                }
            }
            if (nameIsValid) {
                grade5 = Integer.valueOf(request.getParameter("grade5"));
                grade7 = Integer.valueOf(request.getParameter("grade7"));
                grade8 = Integer.valueOf(request.getParameter("grade8"));
                Quest q = new Quest(name, (int) session.getAttribute(constants.TEAM_NUMBER));
                q.setGradeRequirement(Grade.FIFTH, grade5);
                q.setGradeRequirement(Grade.SEVENTH, grade7);
                q.setGradeRequirement(Grade.EIGHTH, grade8);
                QuestSaver qs = new QuestSaver(q);
                qs.saveQuest();
            }%>
        <div style="text-align: center;font-size: larger">
            Quest Saved! <br/>
            Redirecting to skill requirements... <br/>
        </div>
        <script>
            setTimeout(function () {
                window.location = "AddSkillRequirementToQuest.jsp?quest=<%=name%>";
            }, 1000);
        </script>
        <%}%>
    </body>
</html>
