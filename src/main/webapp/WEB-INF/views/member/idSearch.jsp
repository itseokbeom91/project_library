<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자도서관</title>
 <link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
 <style>
fieldset h4{
color:#666;
margin-bottom: 10px;
}

.login_box   {
    border: solid 3px #d4d5d6;
    padding: 40px 180px;
}

.login_box  label {
    width: 95px;
    display: inline-block;
    font-size: 20px;
    color: #666;
    font-weight: bold;
    vertical-align: middle;
}


.login_box input {
    width: 243px;
    height: 40px;
    line-height: 32px;
    font-size: 14px;
    font-weight: bold;
    color: #666;
    padding:0px;
}
.login_check input{
 
 	width: 88px;
    height:	38px;
	padding:0px; 
	margin-left:154px;  
	background-color: #267AC2;
	color:white;
	border: 3px solid #267AC2;
}
.login_check{
margin-left: 150px;
}
.login_find{

margin-left:10px;
font-size: var(--font-small);
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
	
	<h3><div style="border:2px solid lightgray; padding: 15px;">
		<span style="font-weight:bold;">아이디 찾기</span>
		</div>
	</h3>
	
	<fieldset style="border:2px solid lightgray; padding:150px ">
	<form action="/member/idSearchOk" method="post">
		<div style="margin-left:10px;">
			<h3><strong>아이디 찾기</strong></h3>
			<h4>이름과 전화번호를 입력해 주세요.</h4>
		</div>
		
		<div class="login_box"> 
		<ul class="login_innerBox">
			<li><label for="info_name">이름</label><input type="text" id ="info_name" name="name" placeholder="이름을 입력하세요" ></li>
			<li><label for="info_tel">전화번호</label><input type="text" id="info_tel" name="tel" placeholder="전화번호를 입력하세요" ></li>
			
			<ul class ="login_check">
				<li class="l_login_check"><input type="submit" id= "login_check" value="찾기" class="submit"></li>
			</ul>
		</ul>
		</div>

	</form>
	</fieldset>
</article>
</div>	
				

<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
				
</body>
</html>