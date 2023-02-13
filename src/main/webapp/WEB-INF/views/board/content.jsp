<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style >
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
display:flex;
margin-left: 513px;
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

</style>
</head>
<body>
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" />
<div id="wrap">
	
	<h3><div style= "border:1px solid lightgray; padding: 15px; margin-bottom: 32px;">
			<span style="font-weight:bold;">알고싶어요</span>
		</div>
	</h3>
		<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;">	
	<table id="notice">
		<tr>
			<th scope="col" class="tno">글번호</th>
			<td class="left" width="500">${ noticeVo.num }</td>
		</tr>
		<tr>
			<th scope="col" class="tread">조회수</th>
			<td class="left">${ noticeVo.readcount }</td>
		</tr>
		<tr>
			<th scope="col" class="twrite">작성자</th>
			<td class="left">${ noticeVo.id }</td>
		</tr>
		<tr>
			<th scope="col" class="tdate">작성일자</th>
			<td class="left"><fmt:formatDate value="${ noticeVo.regDate }" pattern="yyyy.MM.dd"/></td>
		</tr>
		<tr>
			<th scope="col" class="ttitle">글제목</th>
			<td class="left">${ noticeVo.subject }</td>
		</tr>
		<tr>
			<th scope="col" class="ttitle" height="300px;">글내용</th>
			<td class="left">${ noticeVo.content }</td>
		</tr>
	</table>

	<div id="modi_btns_1">
		<c:if test="${ not empty id }">
			<%-- 로그인 했을때 --%>
			<c:if test="${ id eq noticeVo.id }">
				<%-- 로그인 아이디와 글작성자 아이디가 같을때 --%>
				<p><input type="button" value="글수정" class="btn1" onclick="location.href = '/board/modify?num=${ noticeVo.num }&pageNum=${ pageNum }'"></p>
				<p><input type="button" value="글삭제" class="btn1" onclick="remove()"></p>
			</c:if>
			<c:set var="admin" value="admin"/>
			<c:choose>
				<c:when test="${ id eq admin }">
					<p><input type="button" value="답글쓰기" class="btn1" onclick="location.href = '/board/replyWrite?reRef=${ noticeVo.reRef }&reLev=${ noticeVo.reLev }&reSeq=${ noticeVo.reSeq }&pageNum=${ pageNum }'"></p>	
				</c:when>
			</c:choose>
		</c:if>
		<p><input type="button" value="목록보기" class="btn1" onclick="location.href = '/board/notice?pageNum=${ pageNum }'"></p>
	</div>
	
	<div class="clear"></div>
	<div id="page_control">
	</div>
		
</div>
    
	<div class="clear"></div>
	</div>

<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	function remove() {
		var result = confirm('해당 글을 정말 삭제하시겠습니까?');
		console.log(typeof result);
		
		if (result == false) {
			return;
		}
		
		location.href = '/board/delete?num=${ noticeVo.num }&pageNum=${ pageNum }';
	} // remove
</script>

</body>
</html>   

    