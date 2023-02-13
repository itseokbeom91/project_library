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
		<span style="font-weight:bold;">비밀번호 찾기결과</span>
		</div>
	</h3>
	
	<fieldset style="border:2px solid lightgray; padding:150px ">
		<h3>
			[<strong>${vo.name }</strong>] 님의 임시 비밀번호를 [<strong>${ vo.email }</strong>] 로 발송하였습니다.<br><br><br>
			로그인을 하신 후 반드시 비밀번호를 변경하시기 바랍니다.
		</h3>
	</fieldset>

</article>
</div>

	
</body>
</html>