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
<title>End of game</title>
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
int score = Integer.parseInt(request.getParameter("score"));

//--- repaso
String repaso = request.getParameter("repaso");

%>

<form method="GET" action="start.jsp">

<p class="micro-text">
Jugador: <%=playerName %>
</p>

<div style="margin-left: auto; margin-right: auto; width: 50%; margin-top: 10%;">

<p class="medium-text" style="margin: 0;">
Puntuación final <%=score %> de <%=espanol.size() %>.
</p>

<%
float greenPercent = ((score*100) / espanol.size());
%>
<table style="width: 100%; height: 50px;">
<tr>
  <td style="background-color: green; width: <%=greenPercent %>%;"></td>
  <td style="background-color: lightgrey; width: <%=(100.0 - greenPercent) %>%;"></td>
</tr>
</table>

<% if ((repaso != null) && (!"null".equals(repaso))) { %>
<p class="small-text" style="margin: 0;">
Review the following verbs:<br />
<pre class="small-text" style="margin-left: 40px;"><%=repaso %></pre>
</p>
<% } %>

<p>
<input class="small-text" type="submit" value="Start again" />
<input type="hidden" name="gameData" value="<%=request.getParameter("gameData") %>" />
</p> 

</div>

</form>

</body>
</html>