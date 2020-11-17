<%@page import="java.io.FileReader"%>
<%@page import="com.danimar.irregularVerbsGame.parser.GameDataParser"%>
<%@page import="com.danimar.irregularVerbsGame.data.GameData"%>
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
GameData gameData = GameDataParser.parse(new FileReader(indexJsonFilename));

Vector<String> espanol = gameData.getEspanol();
Vector<String> ingles1 = gameData.getIngles1();
Vector<String> ingles2 = gameData.getIngles2();
Vector<String> ingles3 = gameData.getIngles3();

//--- datos del juego
int question = Integer.parseInt(request.getParameter("question"));
int score = Integer.parseInt(request.getParameter("score"));

// --- pregunta actual
String verb = espanol.get(question);

//--- ayuda
int help = 0;
if (request.getParameter("help") != null) {
	help = Integer.parseInt(request.getParameter("help"));
}

// --- respuesta elegida
String answer1 = request.getParameter("answer1").trim().toLowerCase();
String answer2 = request.getParameter("answer2").trim().toLowerCase();
String answer3 = request.getParameter("answer3").trim().toLowerCase();

//--- repaso
String repaso = request.getParameter("repaso");

// --- sumamos puntos por cada acierto
boolean err1 = false, err2 = false, err3 = false;
if (help < 1) {
	if (ingles1.get(question).equals(answer1)) {
		score++;
	} else {
		err1 = true;
	}
}
if (help < 2) {
	if (ingles2.get(question).equals(answer2)) {
		score++;
	} else {
		err2 = true;
	}
}
if (ingles3.get(question).equals(answer3)) {
	score++;
} else {
	err3 = true;
}

if (err1 || err2 || err3) {
	if ((repaso == null) || "null".equals(repaso)) {
		repaso = "";
	}
	repaso = repaso + "<span class='espanol'>" + verb + "</span> = "
		+ ingles1.get(question) + " / " + ingles2.get(question) + " / "+ ingles3.get(question) + "<br />";
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

<table>
<tr>
	<td class="big-text espanol" colspan="2"><%=verb %></td>
</tr>
<tr>
	<td class="big-text"><%=ingles1.get(question) %></td>
	<td class="big-text">
		<%	if (help < 1) { 
		    	if (!err1) out.write("<span style='color: blue;'>CORRECT!!</span>");
			   	else out.write("<span style='color: red;'>Incorrect!!</span>");
		 	}
		%>
	</td>
</tr>
<tr>
	<td class="big-text"><%=ingles2.get(question) %></td>
	<td class="big-text">
		<%	if (help < 2) { 
		    	if (!err2) out.write("<span style='color: blue;'>CORRECT!!</span>");
			   	else out.write("<span style='color: red;'>Incorrect!!</span>");
		 	}
		%>
	</td>
</tr>
<tr>
	<td class="big-text"><%=ingles3.get(question) %></td>
	<td class="big-text">
		<%	 
	    	if (!err3) out.write("<span style='color: blue;'>CORRECT!!</span>");
		   	else out.write("<span style='color: red;'>Incorrect!!</span>");
		%>
	</td>
</tr>
</table>
<input class="small-text" type="submit" value="Siguiente" autofocus />

</div>

<input type="hidden" name="question" value="<%=(question+1) %>" />
<input type="hidden" name="score" value="<%=score %>" />
<input type="hidden" name="repaso" value="<%=repaso %>" />
<input type="hidden" name="gameData" value="<%=gameDataFilename %>" />
<input type="hidden" name="help" value="<%=request.getParameter("help") %>" />
</form>

</body>
</html>