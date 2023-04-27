<%@page import="kr.co.sist.admin.vo.AdminResultVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String adminId="";
//System.out.println("1.==sesVO is ==============="+session.getAttribute("sesVO") );
if(session.getAttribute("sesVO")==null) {
	String msg="<script>alert('로그인 후 이용해 주세요.');  location.href='http://localhost/prj3/project_admin/1.mainAdmin/adminLogin.jsp'</script>";
	out.print(msg);
}else {
	AdminResultVO arVO=(AdminResultVO)session.getAttribute("sesVO");
	adminId=arVO.getId();
}//end else
%>