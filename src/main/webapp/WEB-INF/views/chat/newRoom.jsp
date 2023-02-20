<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td{
	font-weight: lighter;
}
tbody,td{
 	border:2px solid #ccc;
	text-align:center;
	padding:10px 0;
	font-size: 14px 
}
.tno, .ttitle, .twrite, .tdate, .tread	{
	border:2px solid #ccc;
 	font-size: var(--font-small);
 	width: 130px;
 }
 
.left {
 	 border-bottom:2px solid #ccc;
	font-size: var(--font-small);
 	font-weight: var(--weight-semi-bold);
}

#notice{
	margin: auto;
} 

#notice{
	width: 900px;
	position: relative;
}

#modi_btns_1 {

margin:10px 0 0 430px;	
/* 	background-color: #267AC2;
	color:white; */
	/* border: 1px solid #267AC2; */
	height: 33px;
	width:100px;
	 display:flex; 
	
}
#modi_btns_1 {

margin-left: 620px;
}


#modi_btns_1 .btn1{
	background-color: #267AC2;
	color:white;
	border: 1px solid #267AC2;
	height: 33px;
	width:100px

}


#modi_btns_1 p{
margin-left: 10px;
}

.text-area{
border:none;

}

div#chatbox {
	width: 400px;
	height: 300px;
	border: 1px solid black;
	background-color: lightgray;
	overflow: auto;
}
</style>
<title>Insert title here</title>
</head>
<body>

<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 

<div id="wrap">
	
		
	<h3>
		<div style= "border: 1px solid lightgray; padding: 15px; margin-bottom: 32px;">
			<span style="font-weight:bold;">신청하기(채팅방 형식)</span>
		</div>
	</h3>
		
	<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;" >	
		<form action="/chat/new" method="post" name="frm">
			<input type="hidden" name="pageNum" value="${ pageNum }">
			<input type="hidden" name="id" value="${ id }">
			<table id="notice">

				<tr>
					<th scope="col" class="twrite">작성자</th>
					<td class="left" width="500">
						${ id }
					</td>
				</tr>
				<tr>
					<th scope="col" class="ttitle">방 제목</th>
					<td class="left" >
						<textarea style="resize: none"  rows="5" cols="110" name="title" class="text-area" required></textarea>
					</td>
				</tr>
			</table>

			<div id="modi_btns_1">
				<p><input type="button" value="칸맞추기" class="btn1" style="visibility: hidden;"></p>
				<p><input type="submit" value="채팅방 생성" class="btn1"></p>
				<p><input type="button" value="목록보기" class="btn1" onclick="location.href='/chat/list'"></p>
			</div>

		</form>
	</div>
</div>




<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>