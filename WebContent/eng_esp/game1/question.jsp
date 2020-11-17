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
int question = Integer.parseInt(request.getParameter("question"));
int score = Integer.parseInt(request.getParameter("score"));

// --- pregunta actual y respuesta correcta
String verb = ingles.get(question);
String answerRight = inglesEspanol.get(verb);

// --- dos respuestas erroneas aleatorias
Random rnd = new Random(System.currentTimeMillis());

String answerWrong1 = "";
do {
	answerWrong1 = espanol.get(rnd.nextInt(espanol.size()));
} while (answerWrong1.equals(answerRight));

String answerWrong2 = "";
do {
	answerWrong2 = espanol.get(rnd.nextInt(espanol.size()));
} while (answerWrong2.equals(answerRight) || answerWrong2.equals(answerWrong1));

// --- orden aleatorio de las respuestas
String answer1, answer2, answer3;
int rndPos = rnd.nextInt(3);
if (rndPos == 0) {
	answer1 = answerRight;
	answer2 = answerWrong1;
	answer3 = answerWrong2;
} else if (rndPos == 1) {
	answer1 = answerWrong1;
	answer2 = answerRight;
	answer3 = answerWrong2;
} else {
	answer1 = answerWrong1;
	answer2 = answerWrong2;
	answer3 = answerRight;
}

%>

<form method="GET" action="answer.jsp">

<p class="micro-text">
Jugador: <%=playerName %> / Puntuación: <%=score %> / Pregunta: <%=(question+1) %> de <%=espanol.size() %>
</p>

<div style="margin-left: auto; margin-right: auto; width: 50%; margin-top: 10%;">

<table cellpadding="10" style="width: 100%;">
<tr>
<td class="big-text"><%=verb %></td>
<td>
	<table>
		<tr><td><input class="big-text" style="width: 100%;" type="submit" name="answer" value="<%=answer1 %>"/></td></tr>
		<tr><td><input class="big-text" style="width: 100%;" type="submit" name="answer" value="<%=answer2 %>"/></td></tr>
		<tr><td><input class="big-text" style="width: 100%;" type="submit" name="answer" value="<%=answer3 %>"/></td></tr>
	</table>
</td>
</tr>
</table>

</div>

<input type="hidden" name="question" value="<%=question %>" />
<input type="hidden" name="score" value="<%=score %>" />
<input type="hidden" name="repaso" value="<%=request.getParameter("repaso") %>" />
</form>

</body>
</html>