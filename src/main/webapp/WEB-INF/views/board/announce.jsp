<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
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
	/* /* background-color: #267AC2; */ */
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
</style>
</head>
<body>
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" />
<div id ="wrap"> 
 
	<article>
	
	<h3>
	<div style= "border:1px solid lightgray; padding:15px;">
	<ul style="display: flex; justify-content: space-between;">
		<li><span style="font-weight:bold;">공지사항</span></li>
		<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
		<c:set var="admin" value="admin"/>
		<c:choose>
			<c:when test="${ id eq admin }">
				<li><input type="button" value="글쓰기" class="btn" style=" border-radius:0px; margin:0 10px 0 0; height: 29px; width: 80px;"onclick="location.href='/board/announce/write?pageNum=${ pageNum }'"></li>
			</c:when>
		</c:choose>
	</ul>
	</div>
	</h3>
	<div class="main" style="text-align: left">
	

	<input id="tab1" type="radio" name="tabs" onclick="location.href='/board/notice'">
	<label for="tab1">알고싶어요</label>
	
	<input id="tab2" type="radio" name="tabs" checked>
	<label for="tab2">공지사항</label>

	<input id="tab3" type="radio" name="tabs" onclick="location.href='/chat/list'">
	<label for="tab3">희망도서신청</label>
	

	<section id="content1">
		
		
	</section>
	
	<section id="content2">
	
		<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;">
		
		<table id="notice">
		<thead>
			<tr>
				<th scope="col" width="70" class="tno">번호</th>
				<th scope="col" width="500" class="ttitle">제목</th>
				<th scope="col" width="120" class="twrite">작성자</th>
				<th scope="col"  width="100" class="tdate">작성일자</th>
				<th scope="col"  width="100" class="tread">조회수</th>
			</tr>
			
			<c:choose>
			<c:when test="${ not empty announceList }"><%-- ${ pageDto.count gt 0 } --%>
				
				<c:forEach var="announce" items="${ announceList }">
					<tr>
						<td>${ announce.num }</td>
						<td class="left">
							<a href="/board/announce/content?num=${ announce.num }&pageNum=${ pageNum }"><span>${ announce.subject }</span></a>
						</td>
						<td>
							<c:set var="admin" value="admin"/>
							<c:if test="${ announce.id eq admin }">
								관리자
							</c:if>
<%-- 						${ announce.id } --%>
						</td>
						<td><fmt:formatDate value="${ announce.regDate }" pattern="yyyy.MM.dd"/></td>
						<td>${ announce.readcount }</td>
					</tr>
				</c:forEach>
				
			</c:when>		
			<c:otherwise>
				<tr>
					<td colspan="5">게시판 글 없음</td>
				</tr>
			</c:otherwise>
			</c:choose>
	
		</table>
	
		<div id="table_search_1">
			<form action="/board/announce/notice" method="get">
				<select name="category">
					<option value="subject" ${ pageDto.category eq 'subject' ? 'selected' : '' }>글제목</option>
					<option value="content" ${ pageDto.category eq 'content' ? 'selected' : '' }>글내용</option>
					<option value="id" ${ pageDto.category eq 'id' ? 'selected' : '' }>작성자ID</option>
				</select>
				<input type="text" class="input_box1" name="search" value="${ pageDto.search }">
				<input type="submit" value="검색" class="tableSearch__btn1">
			</form>
		</div>
		
		<div class="clear"></div>
		
		
		<div id="page_control_1">
		<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
		<c:if test="${ pageDto.count gt 0 }">
			<%-- [이전] --%>
			<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
				<a href="/board/announce/notice?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">[이전]</a>
			</c:if>
			
			<%-- 시작페이지 ~ 끝페이지 --%>
			<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
				
				<c:choose>
				<c:when test="${ i eq pageNum }">
					<a href="/board/announce/notice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">[${ i }]</a>
				</c:when>
				<c:otherwise>
					<a href="/board/announce/notice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">[${ i }]</a>
				</c:otherwise>
				</c:choose>
				
			</c:forEach>
			
			<%-- [다음] --%>
			<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
				<a href="/board/announce/notice?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">[다음]</a>
			</c:if>
		</c:if>
		</div>
		</div>

	</section>
	
	<section id="content3">
		
		
	</section>
	
	</article>
    
	<div class="clear"></div>
	

</div>

<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>   
