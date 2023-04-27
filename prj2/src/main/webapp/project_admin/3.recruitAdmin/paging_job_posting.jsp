<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.admin.vo.SearchAdVO"%>
<%@page import="kr.co.sist.admin.dao.JobAdDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ include file="../checkLogin.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용공고 관리</title>
<style type="text/css">
#wrap{ margin:0px auto; width:1200px; min-height:1400px; /* background-color: #333  */ }
#header{ position:relative; height:100px;  }
#container{ position:relative; height:1300px;  background-color: #E0E0E0 }
.logo{ position:absolute; width:230px; height:50px; top:25px; left:0px; border-right:1px solid #CCC }
.page_name{ position:absolute; width:180px; height:40px; top:35px; left:250px; font-size:23px;}
.main_page{ position:absolute; width:80px; height:20px; top:40px; left:1100px; font-size:16px; background-color: #FFF}
.title{ position:absolute; top:50px; left:50px;  font-family:고딕; font-size:26px; }
.board{ position:absolute; top:120px; left:380px; width:400px; height:100px;}
.board2{ position:absolute; top:650px; left:380px; width:400px; height:100px;}
.board_table{ margin:0px auto; text-align:center; font-size:15px;  width:400px; height:100px;  }
.search{ position:absolute; top:280px; left:50px; }
.search2{ position:absolute; top:760px; left:50px; }
.search_btn{ position:absolute; top:283px; left:180px; }
.search_btn2{ position:absolute; top:763px; left:180px; }
.btn{ background-color: #5E5E5E; border:none; width: 52px; height:26px; border-radius:4px; color:white; cursor:pointer }
.chart{ position: absolute; top:320px; left:50px; width: 1100px; min-height:50px; background-color: #E0E0E0; }
.chart2{ position: absolute; top:800px; left:50px; width: 1100px; min-height:300px; background-color: #E0E0E0; }
.chart_table{ border:1.5px solid #CCC; border-spacing: 0px; background-color: #FFF }
.delete{ border:none; width:40px; height:25px; background-color: transparent; cursor:pointer }
.top{ background-color: #323743;  }
.regist_div{ position:absolute; top:273px; left:1050px; }
.regist_btn{ background-color: #3498DB; border:none; width: 100px; height:40px; border-radius:4px; cursor:pointer; color:white; font-size: 16px }
th, tr{ border:1px solid #323743; border:none; border-bottom:0.5px solid #CCC }
td{ text-align:center; font-family:맑은 고딕; font-size:14px; border-bottom:0.2px solid #CCC }
.table1 {
    margin-bottom:10px;
  }

.paging{
text-align:center;
}

</style>
<!-- CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- CDN 끝 -->

<script type="text/javascript">

$(function() {
	
	//진행 중인 공고 검색 버튼
	$("#corp_btn").click(function() {
		
		if($("#corp_text").val()==""){
			alert("입력 후 검색해주세요");
			return;
		}//end if
		
		$("#search_frm").submit();
	});//search_corp
	
	
	
	//마감된 공고 검색 버튼
	$("#dead_btn").click(function() {
		
		if($("#dead_text").val()==""){
			alert("입력 후 검색해주세요");
			return;
		}//end if
		
		$("#deadline_frm").submit();
	});//search_corp
	
	
	
	//등록 버튼
	$("#regist_btn").click(function() {
		location.href="http://localhost/prj2/project_admin/5.recruitAd/recruit.jsp";
	});//regist_btn
	
	
	
	//수정과 삭제는 링크로
	//총 지원자 수 링크로
	//메인 페이지 링크로
	
	
});//ready

</script>

</head>
<body>
<div id="wrap">
<div id="header">

<div class="logo">
<a href="http://localhost/prj2/project_admin/3.recruitAdmin/job_posting.jsp"><img src="http://localhost/prj2/images/devplanet_big.png" alt="데브플래닛"></a>
</div>

<div class="page_name">	
<strong>채용공고 관리</strong>
</div>

<div class="main_page">
<a href="http://localhost/prj2/project_admin/1.mainAdmin/main.jsp" class="list" >메인페이지</a>
</div>

</div>

<div id="container">


<%
request.setCharacterEncoding("UTF-8");



//DB에서 공고번호, 기업명, 공고제목, 인재관리, 등록일자, 마감일자 값을 select 후 담은 searchVO를 반환하는 메서드를 호출

//DAO 객체화
JobAdDAO jDAO = new JobAdDAO();

//DAO의 select메서드 호출 (채용공고 현황(진행중,마감) 보여주기)
List<SearchAdVO> sList = new ArrayList<SearchAdVO>();
List<SearchAdVO> cList = new ArrayList<SearchAdVO>();


//기업명 검색이 없으면 ""
String cName = request.getParameter("searchCorp");
String cName2 = request.getParameter("searchCorp2");


if(cName==null){
	cName="";
}//end if


if(cName2==null){
	cName2="";
}//end if


//총 채용공고
int totalAds = 0;
//채용 중인 기업수
int cntCorps = 0;
//오늘 마감 공고 수
int closingToday = 0;
//마감된 공고
int closedAds = 0;

int pageNum = 0;
int pageSize = 0;
int startRecord = 0;
int endRecord = 0;
int totalRecordCount = 0;
int totalPageCount = 0;
int startPage = 0;
int pageBlock = 0;
int endPage = 0;




try{
	
	//카운트
	totalAds = jDAO.selectCntAll();	
	cntCorps = jDAO.selectCountAdCorp();
	closingToday = jDAO.selectCntclosing();
	closedAds = jDAO.selectCntClosed();
	

////////////////////////////////////////////////////////////////////////////////////////////////////////
//현재 페이지 번호 가져오기
pageNum = request.getParameter("pageNum") == null ? 1 : Integer.parseInt(request.getParameter("pageNum"));

// 한 페이지에 보여줄 레코드 수
pageSize = 10;

System.out.println("현재 페이지 번호: "+pageNum);

// 시작 레코드와 끝 레코드 계산
startRecord = (pageNum - 1) * pageSize + 1;
endRecord = pageNum * pageSize;
System.out.println("시작 레코드: "+startRecord+", 끝 레코드: "+endRecord);

// 총 레코드 수와 총 페이지 수 계산
totalRecordCount = totalAds; //dao.getTotalRecordCount();
totalPageCount = (int) Math.ceil((double) totalRecordCount / pageSize);
System.out.println("총 레코드 수: "+totalRecordCount+", 총 페이지 수: "+totalPageCount);


// 시작 페이지와 끝 페이지 계산
pageBlock = 5; // 페이지 링크 수
startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
endPage = startPage + pageBlock - 1;
if (endPage > totalPageCount) endPage = totalPageCount;
System.out.println("시작 페이지: "+startPage+", 끝 페이지: "+endPage+"-------1트쨰---");


if (pageNum == totalPageCount) { 
    endRecord = totalRecordCount; //39로 < 4페이지, 39개
} else { 
    endRecord = pageNum * pageSize; // 40 < 4페이지, 40개
}

System.out.println("시작 페이지: "+startPage+", 끝 페이지: "+endPage+"-------2트쨰---");

////////////////////////////////////////////////////////////////////////////////////////////////////
	
//리스트 가져오기
	sList = jDAO.selectAd(cName);
	List<SearchAdVO> subList = new ArrayList<SearchAdVO>();
	
	subList = sList.subList(startRecord - 1, endRecord); // sList에서 startRecord부터 endRecord 범위의 레코드만 가져옴
	System.out.println(subList.size()+"서브리스트 크기");
	
	request.setAttribute("sList", subList); // sublist를 request에 담아서 전달
	
	
	cList = jDAO.selectClosedAd(cName2);





	

}catch(SQLException se){
	se.printStackTrace();
%>	
	<script>
		alert("서버에 문제 발생! 잠시 후 다시 시도해주세요.");
		location.href="http://localhost/prj2/project_admin/1.mainAdmin/main.jsp";
	</script>
	
<%	
}//end catch

	
//리스트를 반복시켜 VO에 담긴 값을 화면에 보여준다
//pageContext.setAttribute("sList", sList);
pageContext.setAttribute("cList", cList);



//request 객체에 속성 추가
request.setAttribute("totalPageCount", totalPageCount);
request.setAttribute("startPage", startPage);
request.setAttribute("endPage", endPage);
request.setAttribute("pageNum", pageNum);



%>



<div class="title">
<span class="title_text" style="text-align:center; top:10px; left:10px">
<strong><a href="http://localhost/prj2/project_admin/3.recruitAdmin/job_posting.jsp"  style="text-decoration: none; color: inherit;">채용공고 현황</a></strong></span>
</div>

<div class="board">
<table class="board_table">
<tr>
   <td style="font-size:20px"><%= totalAds %></td>
   <td style="font-size:20px"><%=cntCorps%></td>
   <td style="font-size:20px"><%=closingToday %></td>
</tr>

<tr>
   <td>총 채용공고</td>
   <td>공고중인 기업</td>
   <td>오늘 마감</td>
</tr>
</table>
</div><!-- board -->

<div class="search">
<form name="search_frm" id="search_frm" method="post" action="">
<input type="text" placeholder="기업명 검색" style="width:110px; height:25px" name="searchCorp" id="corp_text"/>
<input type="button" class="btn" value="검색" id="corp_btn"/> 
<input type="button" class="btn" value="새로고침" style="width:70px" id="refresh_btn" onclick="location.href='http://localhost/prj2/project_admin/3.recruitAdmin/job_posting.jsp'"/>
</form>
</div>

<div class="regist_div">
<input type="button" class="regist_btn" value="공고 등록" id="regist_btn">
</div>



<div class="chart">
<form name="ongoingFrm" id="ongoingFrm" action="http://localhost/prj2/project_admin/3.recruitAdmin/total_applicant.jsp">
<input type="hidden" name="pageNum"/>
<table class="chart_table table1">
<colgroup>
			<col style="width:3%">
			<col style="width:6%">
			<col style="width:18%">
			<col style="width:7%">
			<col style="width:6%">
			<col style="width:6%">
			<col style="width:6%">
</colgroup>
<thead>
  <tr class="top">
  <th scope="col" ><font color="#FFF">번호</font></th>
  <th scope="col"><font color="#FFF">기업명</font></th>
  <th scope="col"><font color="#FFF">공고 제목</font></th>
  <th scope="col"><font color="#FFF">인재 관리</font></th>
  <th scope="col"><font color="#FFF">등록 일자</font></th>
  <th scope="col"><font color="#FFF">마감 일자</font></th>
  <th scope="col"><font color="#FFF">수정 / 삭제</font></th>
  </tr>
</thead>
<tbody>

<%
if(sList.size()==0){ //검색된 결과가 없으면
%>	
	<tr>
		<td colspan="7">조회된 결과가 없음</td>
	</tr>
	
<%}else{

%>



<c:forEach var="sVO" items="${sList}" varStatus="i">

<tr>
   <td>
   <c:out value="${i.count }"/>
   </td>
   <td><c:out value="${sVO.cName}"/></td> <!-- 기업명 출력 -->
   <td><c:out value="${sVO.title}"/></td> <!-- 공고 제목 출력 -->
    <td><!-- 총 지원자 수 출력 -->
	  <%
	  /* //공고 제목을 넘기기 위해 세션에 저장함
	  	//변수 선언
	  	SearchAdVO value = (SearchAdVO)pageContext.getAttribute("sVO");
	  
  		// 채용 공고 제목
  		String jobTitle = value.getTitle();

  		// 세션에 저장
 		 session.setAttribute("jobTitle", jobTitle); */

  	%>
    <a href="http://localhost/prj2/project_admin/3.recruitAdmin/total_applicant.jsp?jobNum=${sVO.jobNum}&cName=${sVO.cName}&jobTitle=${sVO.title}">  
   총 지원자 <c:out value="${sVO.totalApply}"/>명</a>
   </td> <!-- 총 지원자 수 출력 -->
   <td><c:out value="${sVO.inputDate}"/></td><!-- 공고 등록일 출력 -->
   <td><c:out value="${sVO.endDate}"/></td><!-- 공고 마감일 출력 -->

   <td><a href="http://localhost/prj2/project_admin/5.recruitAd/recruitmod.jsp?jobNum=${sVO.jobNum}">수정</a><!--공고 수정페이지  -->
    / <a href="http://localhost/prj2/project_admin/5.recruitAd/delete_process.jsp?jobNum=${sVO.jobNum}" onclick="return confirm('[${sVO.cName}] 기업의 해당 공고를 삭제하시겠어요?')" id="delete">삭제</a></td><!--삭제처리 페이지  -->
</tr>
</c:forEach>
</tbody>

</table>
</form>

<!-- 페이징 부분 -->
<div style="border:1px solid #333">
  <!-- 이전 페이지 링크 -->
  <c:if test="${startPage > 1}">
    <a href="${request.requestURI}?pageNum=${startPage - 1}">이전</a>
  </c:if>

  <!-- 페이지 번호 링크 -->
  <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
    <c:choose>
      <c:when test="${i eq pageNum}">
        <a class="current"><c:out value="${pageNum}" /></a>
      </c:when>
      <c:otherwise>
        <a href="${request.requestURI}?pageNum=${i}"><c:out value="${i}" /></a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <!-- 다음 페이지 링크 -->
  <c:if test="${endPage < totalPageCount}">
    <a href="${request.requestURI}?pageNum=${endPage + 1}">다음</a>
  </c:if>
</div>










</div>






<%} //end else %>

<%-- 
<div class="board2">
<table class="board_table">
<tr>
   <td style="font-size:20px"><%=closedAds %></td>
</tr>

<tr>
   <td>마감된 공고</td>
</tr>
</table>
</div><!-- board -->

<div class="search2">
<form action="http://localhost/prj2/project_admin/3.recruitAdmin/job_posting.jsp" name="deadline_frm" id="deadline_frm">
<input type="text" placeholder="기업명 검색" style="width:110px; height:25px" name="searchCorp2" id="dead_text" >
<input type="button" class="btn" value="검색" id="dead_btn"> 
<input type="button" class="btn" value="새로고침" style="width:70px" id="refresh_btn" onclick="location.href='http://localhost/prj2/project_admin/3.recruitAdmin/job_posting.jsp'"/>

</form>
</div>

<div class="chart2">
<form name="deadlineFrm" id="deadlineFrm" action="http://localhost/prj2/project_admin/3.recruitAdmin/total_applicant.jsp">
<table class="chart_table">
<colgroup>
			<col style="width:3%">
			<col style="width:6%">
			<col style="width:18%">
			<col style="width:7%">
			<col style="width:6%">
			<col style="width:6%">
			<col style="width:6%">
</colgroup>
<thead>
  <tr class="top">
  <th scope="col" ><font color="#FFF">번호</font></th>
  <th scope="col"><font color="#FFF">기업명</font></th>
  <th scope="col"><font color="#FFF">공고 제목</font></th>
  <th scope="col"><font color="#FFF">인재 관리</font></th>
  <th scope="col"><font color="#FFF">등록 일자</font></th>
  <th scope="col"><font color="#FFF">마감 일자</font></th>
  <th scope="col"><font color="#FFF">삭제</font></th>
  </tr>
</thead>

<tbody>

<%
if(cList.size()==0){ //검색된 결과가 없으면
%>	
	<tr>
		<td colspan="7">조회된 결과가 없음</td>
	</tr>
	
<%}else{
%>


<c:forEach var="cVO" items="${cList}" varStatus="i">
 	<input type="hidden" name="cjobNumH" value="${cVO.jobNum}"> 
   <input type="hidden" name="ccNameH" value="${cVO.cName}"> 
<tr>
   <td><c:out value="${i.count }"/></td>
   <td><c:out value="${cVO.cName}"/></td> <!-- 기업명 출력 -->
   <td><c:out value="${cVO.title}"/></td> <!-- 공고 제목 출력 -->
  <td><!-- 총 지원자 수 출력 -->
	  <%
	  	//변수 선언
	  	SearchAdVO value = (SearchAdVO)pageContext.getAttribute("cVO");
	  
  		// 채용 공고 제목
  		String jobTitle = value.getTitle();

  		// 세션에 저장
 		 session.setAttribute("jobTitle", jobTitle);

  	%>
    <a href="http://localhost/prj2/project_admin/3.recruitAdmin/total_applicant.jsp?jobNum=${cVO.jobNum}&cName=${cVO.cName}&jobTitle=${sVO.title}">  
   총 지원자 <c:out value="${cVO.totalApply}"/>명</a>
   </td> <!-- 총 지원자 수 출력 -->
   <td><c:out value="${cVO.inputDate}"/></td><!-- 공고 등록일 출력 -->
   <td><c:out value="${cVO.endDate}"/></td><!-- 공고 마감일 출력 -->
   
   <!--날 좀 고쳐라  -->
   <!--페이지 연결 해야함-->
   <td><a href="http://localhost/prj2/project_admin/5.recruitAd/recruitmod.jsp?jobNum=${cVO.jobNum}">수정</a><!--공고 수정페이지  -->
    / <a href="http://localhost/prj2/project_admin/5.recruitAd/delete_process.jsp?jobNum=${cVO.jobNum}" onclick="return confirm('[${cVO.cName}] 기업의 해당 공고를 삭제하시겠어요?')">삭제</a></td><!--삭제처리 페이지  -->
</tr>
</c:forEach>
</tbody>

</table>
</form>
</div> <!-- chart2 -->
<%}//end else %> --%>

</div><!-- container -->
</div><!-- wrap -->
</body>
</html>