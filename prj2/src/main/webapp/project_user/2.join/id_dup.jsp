<%@page import="kr.co.sist.user.dao.UserDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://211.63.89.139/jsp_prj/common/main_v20230217.css">
<style type="text/css">
#wrap{ width: 400px; height: 400px; margin: 0px auto;  }

</style>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN 끝 -->
<script type="text/javascript">
$(function() {
	$("#btn").click(function() {
		if($("#id").val() == "") {
			alert("아이디는 필수 입력!!");
			return;
		}//end if
		
		$("#frm").submit(); //id_dup.jsp로 POST방식의 요청
		
	});//click
	
});//ready

function sendId(id) {
	opener.window.document.joinFrm.userId.value=id;
	self.close();
}//sendId

</script>
</head>
<body>
<div id="wrap"> 
<form action="id_dup.jsp" method="post" id="frm">
<div style="top:20px">
<h2>아이디 중복 확인</h2><br/>
</div>
<label>아이디</label>
<input type="text" autofocus="autofocus" name="id" id="id" class="inputBox" style="width:250px"/>
<input type="button" value="중복확인" class="btnBorder" id="btn"/>
</form>
<%

request.setCharacterEncoding("UTF-8");

String id=request.getParameter("id");
if( "POST".equals(request.getMethod()) && !"".equals(id) ) {
	
	//IdDupDAO idDAO=new IdDupDAO();
	UserDAO uDAO=new UserDAO();
	try{
	String resultId=uDAO.selectIdDup(id);
	
%>
<div id="searchResult">
<%if("".equals(resultId)) { // 아이디 사용가능%>
입력하신 <span style="font-weight: bold; color:#0142BA; font-size:20px">
<%= id %></span>는 사용가능합니다.<br/>
<a href="#void" onclick="sendId('<%= id %>')">사용하기</a>

<%}else { // 아이디 중복이므로 사용 불가능%>

입력하신 <span style="font-weight: bold; color:#E43C2F; font-size:20px">
<%= id %></span>는 이미 사용중인 아이디 입니다.<br/>
다른 아이디를 입력해 주세요.

<%}//end else %>

</div>
<%
	}catch(SQLException se) {
		se.printStackTrace();
	%>
	아이디 중복확인 중 문제가 발생했습니다.<br/> 잠시 후 다시 시도해 주세요.
	<%
	}//end catch
}//end if%>
</div>
</body>
</html>