<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a.active {
	font-weight: bold;
}

#notice{
	width: 900px;
	position: relative;
}
 input[type="button"] {
 	margin-bottom:10px;
    width: 120px;
    height: 35px;
    border:1px solid lightgray;
   	font-weight: bold;
   	color: #4d4d4d;
   	background-color: #eeeeee;
    border-radius: 4px;
}

#notice{
margin: auto;

}

.tno, .ttitle, .twrite, .tdate, .tread	{
 background-color: #267AC2;
 color:  white;
 font-size: var(--font-small);
 
 }

thead, th{
	height:40px;
	border-top:2px solid #09C;
	border-bottom:1px solid #CCC;
	font-weight: bold;
	font-size: 15px;
}

tbody,td{
	text-align:center;
	padding:10px 0;
	border-bottom:1px solid #CCC; height:20px;
	font-size: 14px 
}

 .left {
font-size: var(--font-small);
 font-weight: var(--weight-semi-bold);
}

td{

font-weight: lighter;
}
#table_search_1{
	display:flex;
	height:50px;
	justify-content: center;
	/* /* background-color: #267AC2; */
	margin:auto;
	padding-top: 15px;
	width:100%;
	/* margin-top: 10px; */

}
#table_search_1 select{
/* 	border:none; */
border:1px solid #ccc;
	background-color: #ffffff;
	height: 32px;
	width:90px;
	cursor: pointer;
}

.input_box1	{
  border:1px solid #ccc;
  width: 490px;
  height: 30px;
}

.tableSearch__btn1{
	/* border:none; */
	
	background-color: #267AC2;
	color:white;
	border: 1px solid #267AC2;
	height: 33px;
	width:100px
}
#page_control_1 a{

padding-right: 10px;
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
<div id ="wrap"> 
 
	<article id="app">
	
	<h3>
	<div style= "border:1px solid lightgray; padding:15px;">
	<ul style="display: flex; justify-content: space-between;">
		<li><span style="font-weight:bold;">희망도서신청(채팅)</span></li>
			<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
		<c:if test="${ not empty sessionScope.id }">
			<li><input type="button" value="신청하기" class="btn" style=" border-radius:0px; margin:0 10px 0 0; height: 29px; width: 80px;" onclick="location.href='/chat/new'"></li>
		</c:if>
	</ul>
	</div>
	</h3>
	<div class="main" style="text-align: left">
	

	<input id="tab1" type="radio" name="tabs" onclick="location.href='/board/notice'">
	<label for="tab1">알고싶어요</label>
	
	<input id="tab2" type="radio" name="tabs" onclick="location.href='/board/announce/notice'">
	<label for="tab2">공지사항</label>

	<input id="tab3" type="radio" name="tabs" checked>
	<label for="tab3">희망도서신청(채팅)</label>
	

	<section id="content1">
		
		
	</section>
	
	<section id="content2">
	
		

	</section>
	
	<section id="content3">
		
		<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;">
			
			<table id="notice">
			<thead>
				<tr>
					<th scope="col" width="690" class="ttitle">제목</th>
					<th scope="col"  width="200" class="tread">입장</th>
				</tr>
				
				<c:choose>
				<c:when test="${ not empty roomList }"><%-- ${ pageDto.count gt 0 } --%>
					
					<c:forEach var="room" items="${ roomList }">
						<tr>
							<td class="left">
								${ room.title }
							</td>
							<td>
								<input type="button" value="채팅방 입장하기" onclick="location.href='/chat/room/${ room.roomId }'">
							</td>
						</tr>
					</c:forEach>
				</c:when>		
				<c:otherwise>
					<tr>
						<td colspan="2">채팅방 없음</td>
					</tr>
				</c:otherwise>
				</c:choose>
		
			</table>
		</div>
		
	</section>
	
	</article>
    

</div>




<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>