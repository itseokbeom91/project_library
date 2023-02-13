<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>
<title>전자도서관</title>
 <link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
 <style>
fieldset h4{
	color:#666;
	margin-bottom: 10px;
}
.btn {
	width: 90px;
    height:	38px;
	padding:0px; 
/* 	margin-left:154px;   */
	background-color: #267AC2;
	color:white;
	border: 3px solid #267AC2;
}
</style>
</head>
<body>
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" />
<div id="wrap">
<article>

	<h3>
		<div style="border:2px solid lightgray; padding: 15px;">
		<span style="font-weight:bold;">아이디 찾기</span>
		</div>
	</h3>
	
	<fieldset style="border:2px solid lightgray; padding:150px ">
	<div style="margin-left:10px; text-align: center;">
		<h4>${ vo.name }님의 아이디는</h4>
		<h3><strong>${ vo.id }</strong></h3>
		<h4>입니다.</h4>
		<button class="btn" onclick="location.href='/member/login'">로그인 하기</button>
		<button class="btn" onclick="location.href='/member/passwordSearch'">비밀번호 찾기</button>
	</div>	
	</fieldset>
	
	
</article>
</div>

	
<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />		
</body>
</html>