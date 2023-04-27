<%@page import="java.security.GeneralSecurityException"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.dao.UserDAO"%>
<%@page import="kr.co.sist.user.vo.LoginResultVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원탈퇴"
    %>
<%
String name=request.getParameter("quit");
LoginResultVO lrVO=null;

lrVO=(LoginResultVO)session.getAttribute("sesVO");

String userId=lrVO.getUserId();

UserDAO uDAO=new UserDAO();

int result=0;
try{
	
result = uDAO.updateQuit(userId, name);
}catch(GeneralSecurityException gse) {
}catch(UnsupportedEncodingException uee) {
}catch(SQLException se) {
	se.printStackTrace();
}//catch

if(result>0) {
%>
<script>
alert("탈퇴되었습니다. 감사합니다.");
location.href="http://localhost/prj2/project_user/1.main/main_page.jsp";
</script>
<%
}else {
	%>
	<script>
	alert("탈퇴신청자를 다시 확인 해 주세요.");
	history.back();
	</script>
	<%
}//end else
%>