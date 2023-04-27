<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.dao.ResumeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN 끝 --> 
<%-- 이력서 등록 버튼 누르면 insert ResumePkVO --%>
<jsp:useBean id="rpVO" class="kr.co.sist.user.vo.ResumePkVO"/>
<jsp:useBean id="udVO" class="kr.co.sist.user.vo.UserDataVO"/>
<%
String kim1= "kim1";
%>
<%
rpVO.setUserId("kim1");
%> 
<%
 udVO.setName(udVO.getName());
 %>
<%
ResumeDAO rDAO = new ResumeDAO(); 

	
 try{
	 rDAO.selectUserData("kim1");  
	 /* rDAO.insertResume(rpVO); */
}catch(SQLException se){
	se.printStackTrace();
}//end catch 
	
 	/* //forward
	String url = "/project_user/4.resume/1.resume_add.jsp";
	RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	dispatcher.forward(request, response);  */ 
	
	/* // redirect
	String url = "http://localhost/prj3/project_user/4.resume/1.resume_add.jsp";
	response.sendRedirect(url); */
%>
