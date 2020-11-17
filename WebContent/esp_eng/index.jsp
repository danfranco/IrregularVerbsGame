<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>De espa&ntilde;ol a english</title>
<link rel="stylesheet" type="text/css" href="../css/main.css" />
</head>
<body>

<%
JSONParser parser = new JSONParser();

String indexJsonFilename = request.getSession().getServletContext().getRealPath("/conf") + "\\index.json";
JSONObject jsonObject = (JSONObject) parser.parse(new FileReader(indexJsonFilename));
%>

<div style="margin-left: auto; margin-right: auto; width: 50%;">

<%
JSONArray sectionList = (JSONArray) jsonObject.get("sectionList");
for (int i=0; i<sectionList.size(); i++) {
	JSONObject section = (JSONObject) sectionList.get(i);
	
	String label = (String) section.get("label");
	String gameUri = (String) section.get("gameUri");
	JSONArray gameList = (JSONArray) section.get("gameList");
%>
	<p style="margin-bottom: 5%;">
		<span class="small-text"><%= label %></span><br/>
		<span class="micro-text">
<%
	for (int g=0; g<gameList.size(); g++) {
		JSONObject game = (JSONObject) gameList.get(g);
		
		String gameLabel = (String) game.get("label");
		String gameFile = (String) game.get("file");
%>
		- <a href="<%=gameUri %>/start.jsp?gameData=<%=gameFile %>"><%=gameLabel %></a><br />
<%
	}		
%>
		</span>
	</p>
	<%
}
%>

<p class="micro-text">
<span class="small-text">Or change language:</span><br/>
<span class="micro-text">
- <a href="../index.jsp">Change language</a><br />
</span>
</p>

</div>

</body>
</html>