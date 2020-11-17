<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.danimar.irregularVerbsGame.parser.SimpleGameDataParser"%>
<%@page import="com.danimar.irregularVerbsGame.data.SimpleGameData"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question</title>
<link rel="stylesheet" type="text/css" href="../../css/main.css" />
<script src="../../js/nobackbutton.js" ></script>
</head>
<body onLoad="nobackbutton();">

<%
// --- player name
if (request.getParameter("name") != null) {
	session.setAttribute("playerName", request.getParameter("name"));
}
String playerName = (String) session.getAttribute("playerName");

// --- tablas de ingles y español
String gameDataFilename = request.getParameter("gameData");
String indexJsonFilename = request.getSession().getServletContext().getRealPath("/conf") + "\\" + gameDataFilename;
SimpleGameData gameData = SimpleGameDataParser.parse(new FileReader(indexJsonFilename));

Vector<String> espanol = gameData.getEspanol();
Vector<String> ingles = gameData.getIngles();

//--- datos del juego
int question = Integer.parseInt(request.getParameter("question"));
int score = Integer.parseInt(request.getParameter("score"));

// --- pregunta actual y respuesta correcta
String verb = espanol.get(question);

// --- ayuda
int help = 0;
if (request.getParameter("help") != null) {
	help = Integer.parseInt(request.getParameter("help"));
}

%>

<form method="GET" action="answer.jsp">

<p class="micro-text">
Jugador: <%=playerName %> / Puntuación: <%=score %> / Pregunta: <%=(question+1) %> de <%=espanol.size() %>
</p>

<div style="margin-left: auto; margin-right: auto; width: 50%; margin-top: 10%;">

<div class="big-text espanol"><%=verb %></div>
<input class="big-text" type="text" name="answer" autocomplete="off" autofocus

<% if (help > 0) {
		String answerRight = ingles.get(question);
		String helpValue = answerRight;
		if (help < answerRight.length()) {
			helpValue = answerRight.substring(0, help);
		}
%>
value="<%=helpValue %>"
<% } %>

 />

<input class="big-text" type="submit" value="-->" />

</div>

<input type="hidden" name="question" value="<%=question %>" />
<input type="hidden" name="score" value="<%=score %>" />
<input type="hidden" name="repaso" value="<%=request.getParameter("repaso") %>" />
<input type="hidden" name="gameData" value="<%=gameDataFilename %>" />
<input type="hidden" name="help" value="<%=help %>" />
</form>

</body>
</html>