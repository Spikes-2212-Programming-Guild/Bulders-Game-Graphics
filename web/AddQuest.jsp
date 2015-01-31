<%-- 
    Document   : AddQuest
    Created on : Jan 31, 2015, 9:52:29 AM
    Author     : thinkredstone
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>!</title>
    </head>
    <body>
        <%!
            String name;
            String grade5;
            String grade7;
            String grade8;
        %>
        <%name = request.getParameter("name");%>
        <%
            if (name == null) {
        %>
        <h1 style="text-align: center">
            Make a <del>Needles Grinding Task</del> Quest!
        </h1> <br/>
        <form action="AddQuest.jsp" method="post">
            Name: <input type="text" name="name" id="name" value="Enter a name" onfocus="document.getElementById('name').value = ''"/> <br/>
            <input type="submit" value="Move to Requirments!" name="submit" />
        </form>
        <%
        } else {
        %>
        <h1 style="text-align: center">Choose <del>Size</del> GRADE Requirements!</h1> <br/>
        <form method ="post" action="AddQuest.jsp" id="requirements">
            <input type="hidden" value="<%=name%>"/>
            Grade Requirements: 
            <input type="submit" style="position: relative; left: 120px; top: 43px" value="Choose Your Just Rewards!"/> <br/>
            FIFTH: <input type="number" name="grade5" value="0" style="position: relative; left: 28px" /> <br/>
            SEVENTH: <input type="number" name="grade7" value="0" /> <br/>
            EIGHTH: <input type="number" name="grade8" value="0" style="position: relative; left: 13px"/> <br/>
            <input type="text"/>
        </form>
        <%}%>
    </form>
</body>
</html>
