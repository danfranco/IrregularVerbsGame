<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Start game</title>
<link rel="stylesheet" type="text/css" href="../../css/main.css" />
</head>
<body>

<%
// --- player name
String playerName = (String) session.getAttribute("playerName");
if (playerName == null) {
	playerName = "";
}
%>

<div style="margin-left: auto; margin-right: auto; width: 50%; margin-top: 10%;">

<form method="GET" action="question.jsp">
<div class="big-text">Write your name:</div>
<input class="big-text" type="text" name="name" value="<%=playerName %>" autofocus />
<input class="medium-text" type="submit" value="Start game!" />
<input type="hidden" name="question" value="0" />
<input type="hidden" name="score" value="0" />
<input type="hidden" name="gameData" value="<%=request.getParameter("gameData") %>" />
</form>

<form method="GET" action="../index.jsp" style="margin-top: 30px;">
<input class="small-text" type="submit" value="Or try other game" />
</form>

</div>

</body>
</html>