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
<title>Answer</title>
<link rel="stylesheet" type="text/css" href="../../css/main.css" />
<script src="../../js/nobackbutton.js" ></script>
</head>
<body onload="nobackbutton();">

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
String answerRight = ingles.get(question);

// --- respuesta elegida
String answer = request.getParameter("answer");

//--- repaso
String repaso = request.getParameter("repaso");

// --- sumamos punto si se acertó
if (answer.equals(answerRight)) {
	score++;
}
else {
	if ((repaso == null) || "null".equals(repaso)) {
		repaso = "";
	}
	repaso = repaso + "<span class='espanol'>" + verb + "</span> = " + answerRight + "<br />";
}

%>

<% if ((question+1) < espanol.size()) { %>
<form method="GET" action="question.jsp">
<% } else { %>
<form method="GET" action="end.jsp">
<% } %>

<p class="micro-text">
Jugador: <%=playerName %> / Puntuación: <%=score %> / Pregunta: <%=(question+1) %> de <%=espanol.size() %>
</p>

<div style="margin-left: auto; margin-right: auto; width: 50%; margin-top: 10%;">

<p class="medium-text" style="margin: 0;">
<% if (answer.equals(answerRight)) { %>
<span style="color: blue;">CORRECT!!</span>
<% } else { %>
<span style="color: red;">Incorrect!!</span>
<% } %>
</p>

<p class="big-text">
<span class='espanol'><%=verb %></span> = <%=answerRight %> <input class="small-text" type="submit" value="Siguiente" autofocus />
</p>

</div>

<input type="hidden" name="question" value="<%=(question+1) %>" />
<input type="hidden" name="score" value="<%=score %>" />
<input type="hidden" name="repaso" value="<%=repaso %>" />
<input type="hidden" name="gameData" value="<%=gameDataFilename %>" />
</form>

</body>
</html>