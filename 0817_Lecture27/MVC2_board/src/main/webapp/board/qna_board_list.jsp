<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.board.db.*" %>

<%
    List<BoardBean> boardList = (List<BoardBean>)request.getAttribute("boardlist");
	int listcount = ((Integer)request.getAttribute("listcount")).intValue(); 
	
	//List boardList=(List)request.getAttribute("boardlist");
	//int listcount=((Integer)request.getAttribute("listcount")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width=50% cellpadding="0" cellspacing="0">
		<%
			if(listcount > 0){
		%>
		<tr align="center" valign="middle">
			<td colspan="4">MVC게시판</td>
			<td>글의 개수 : <%=listcount %></td>
		</tr>
		<tr>
			<td width="8%" height="26"><div align="center">번호</div> </td>
			<td width="50%" height="26"><div align="center">제목</div> </td>
			<td width="14%" height="26"><div align="center">작성자</div> </td>
			<td width="17%" height="26"><div align="center">날짜</div> </td>
			<td width="11%" height="26"><div align="center">조회수</div> </td>
		</tr>
		
		<%	
		for(int i=0; i< boardList.size(); i++){
			BoardBean bl = boardList.get(i);
				//BoardBean bl=(BoardBean)boardList.get(i);
		%>
		<tr>
			<td width="8%" height="26"><%=bl.getBOARD_NUM() %></td>
			<td width="50%" height="26"><%=bl.getBOARD_SUBJECT() %></div> </td>
			<td width="14%" height="26"><%=bl.getBOARD_NAME() %></td>
			<td width="17%" height="26"><%=bl.getBOARD_DATE() %></td>
			<td width="11%" height="26"><%=bl.getBOARD_READCOUNT() %> </td>
		</tr>
		<%} %>
		
		<%}else{ %>
		
		  <tr align="center" valign="middle">
		  	<td colspan="4">MVC 게시판</td>
		  	<td align="right">
		  		등록된 글이 없습니다.
		  	</td>
		  </tr>
		
		<%} %>
		<tr align="right">
			<td colspan="5">
				<a href="./BoardWrite.bo">[글쓰기]</a>
			</td>
		</tr>
	</table>
</body>
</html>