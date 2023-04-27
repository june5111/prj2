<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.admin.dao.AdminUserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="check_login.jsp" %>
<%
AdminUserDAO auDAO = new AdminUserDAO();

String userId = request.getParameter("user_id");
try {
    auDAO.updateQuitUser(userId);
    response.sendRedirect("http://localhost/prj2/project_admin/6.memberAdmin/member_manage.jsp");
} catch (SQLException e) {
    e.printStackTrace();
%>
    <script>
    alert("시스템 작업도중 문제가 발생했습니다. 잠시후 다시시도해 주세요");
    history.back();
    </script>
<%
}
%>