<%@page import="java.util.Random"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/main.css" />
</head>
<body>

<%
// --- player name
if (request.getParameter("name") != null) {
	session.setAttribute("playerName", request.getParameter("name"));
}
String playerName = (String) session.getAttribute("playerName");

// --- tablas de ingles y español
Vector<String> espanol = new Vector<String>();
Vector<String> ingles = new Vector<String>();
Hashtable<String,String> inglesEspanol = new Hashtable<String,String>();

String esp, ing;
esp="ser/estar"; ing="be"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="convertirse"; ing="become"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="comenzar"; ing="begin"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="soplar"; ing="blow"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="romper"; ing="break"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="traer"; ing="bring"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="construir"; ing="build"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="comprar"; ing="buy"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="atrapar"; ing="catch"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);
esp="venir"; ing="come"; inglesEspanol.put(ing, esp); espanol.add(esp); ingles.add(ing);

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

<% if ((repaso != null) && (!"null".equals(repaso))) { %>
<p class="small-text" style="margin: 0;">
Review the following verbs:<br />
<pre class="small-text" style="margin-left: 40px;"><%=repaso %></pre>
</p>
<% } %>

<p>
<input class="small-text" type="submit" value="Start again" />
</p> 

</div>

</form>

</body>
</html>