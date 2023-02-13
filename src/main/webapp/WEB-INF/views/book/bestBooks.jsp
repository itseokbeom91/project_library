<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all">
<title>전자도서관</title>
<link rel="icon" type="image/png" href="images/book-reader-solid.png">

<style>
* {
	padding: 0;
	margin: 0;
	list-style: none;
} 

.book_info{
    padding: 1px 60px 0 0;
}

.bookList{
	display:inline-flex;
	padding: 12px 30px;
}

.book_img {
	display:inline;
	margin-right: 5%;
}

.inner_category{
font-size: 12px;
    font-weight: bold;
    color: #999;
}

.subject  {
    margin: 2px 0 18px 0;
    font-size: 18px;
    color: #444;
    font-weight: bold;
 }
    
.inner_info{
	color: #666;
    font-size: 14px;
	margin: 0 0 5px 0;
}

.inner_info span{
	display: inline-block;
    margin: 0 2px 0 0;
    padding: 2px 7px 0 0;
    line-height: 12px;
    border-right: solid 2px #d4d5d6;
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

.book_btn {
	margin-top: 10px;
}

.book_btn input[type="button"]:hover{
	color:white;
	background-color: #4C94F1;
	border:1px solid lightgray; 
}

.book_list li .book_info li.text {
    margin: 24px 0 0 0;
    font-size: 12px;
    line-height: 18px;
    color: #999;
}

.text{
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box; 
	-webkit-line-clamp: 2; 
	-webkit-box-orient: vertical; 
	 margin: 20px 0 0 0;
     font-size: 14px;
     color: #999;
}
</style>


</head>
<body>

<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 

<div id ="wrap"> 

	<input type="hidden" name="memberId" id="memberId" value="${ id }">
	
	<h3><div style= "border:1px solid lightgray; padding: 15px;">
			<span style="font-weight:bold;">베스트</span>
		</div>
	</h3>
	
	<div class="main" style="text-align: left">

	<input id="tab1" type="radio" name="tabs" checked>
	<label for="tab1">전체</label>
	
<!-- 	<input id="tab2" type="radio" name="tabs"> -->
<!-- 	<label for="tab2">베스트</label> -->
	
<!-- 	<input id="tab3" type="radio" name="tabs"> -->
<!-- 	<label for="tab3">추천순</label> -->

	<section id="content1">
	
		<div id="bookContent_sy" style="margin-bottom: 40px;">

	<c:choose>
		<c:when test="${ not empty bookList }">
		<c:forEach var="book" items="${ bookList }">
				<input type="hidden" name="bookNum" id="bookNum" value="${ book.num }">
			<ul class="bookList" width="898" height="182">	
				<div class="book_img">
					<c:if test="${ not empty book.cover }">
						<a href="/book/content?num=${ book.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ book.cover }" width="82" height="112"></a>
					</c:if>
				</div>
			<ul class="book_info" >
				<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0" width="49" height="18"; ">[${ book.sort }]</li>
				<li class="subject"><a href="/book/content?num=${ book.num }&pageNum=${ pageNum }">${ book.bookName }</a></li>
				<li class="inner_info"><span>${ book.publisher }</span>
					<span>${ book.writer }</span>
					<span class="end" style="border:none;">${ book.birth }</span>
				</li>
				<li class="inner_info"><span><strong>대출  ${ book.borrowCount } /5</strong></span>
					<span><strong>예약  ${ book.reserveCount } /5</strong></span>
					<span><strong>누적 대출  ${ book.totalBorrow }</strong></span>
					<span><strong>추천  ${ book.recommendCount }</strong></span>
					<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
				</li>
				<li class="text">${ book.introduceBook }</li>
			</ul>
			<ul class="book_btn">
					<c:choose>
						<c:when test="${ book.borrowCount lt 5 }">
							<input type="button" value="대출하기" id="borrow${ book.num }" style="display: block;">
							<input type="button" value="예약하기" id="reserve${ book.num }" style="display: none;">
						</c:when>
						<c:when test="${ book.borrowCount ge 5 and book.reserveCount lt 5 }">
							<input type="button" value="대출하기" id="borrow${ book.num }" style="display: none;">
							<input type="button" value="예약하기" id="reserve${ book.num }" style="display: block;">
						</c:when>
						<c:when test="${ book.reserveCount ge 5 }">
							<input type="button" value="대출하기" id="borrow${ book.num }" style="display: none;">
							<input type="button" value="예약하기" id="reserve${ book.num }" disabled="disabled">
						</c:when>
					</c:choose>
						
							<input type="button" value="추천하기" id="recommend${ book.num }">
			</ul>
		</ul>	
				<hr>
	</c:forEach>
	</c:when>
			<c:otherwise>
				책 없음
			</c:otherwise>
	</c:choose>

</div>

	<ul id="page_control">
	
	<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
	<c:if test="${ pageDto.count gt 0 }">
		<%-- [이전] --%>
		<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
		<li class="div2"><a href="/book/bestBooks?pageNum=${ pageDto.startPage - pageDto.pageBlock }"><i class="far fa-angle-left"></i></a></li>
		</c:if>
		
		<%-- 시작페이지 ~ 끝페이지 --%>
		<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
			
			<c:choose>
			<c:when test="${ i eq pageNum }">
				<li class="div2 active"><a href="/book/bestBooks?pageNum=${ i }">${ i }</a></li>
			</c:when>
			<c:otherwise>
				<li class="div2"><a href="/book/bestBooks?pageNum=${ i }">${ i }</a><li>
			</c:otherwise>
			</c:choose>
			
		</c:forEach>
		
		<%-- [다음] --%>
		<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
			<li class="div2"><a href="/book/bestBooks?pageNum=${ pageDto.startPage + pageDto.pageBlock }"><i class="fal fa-angle-right"></i></a></li>
		</c:if>
	</c:if>
	
	</ul>
	</div>

	</div>

	</section>

<!-- 	<section id="content2"> -->
		
<!-- 	</section> -->
	
<!-- 	<section id="content3"> -->
	
<!-- 	</section> -->
	
	
	<script src="/script/jquery-3.5.1.js"></script>
<script>


	
	// 대출하기
	$("[id^='borrow']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(6,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

		location.href = '/use/borrow?' + result;

// 		var memberId = $('#memberId').serialize();
// 		var bookNum = $('#bookNum').serialize();
		
// 		var result = (memberId+'&'+bookNum);
// 		console.log(result);

// 		$.ajax({
// 			url: '/borrow',
// 			data: result
// 			success: function() {
// 				location.href = '/'
// 			}
// 		})
		
	});


	// 예약하기
	$("[id^='reserve']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(7,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

		location.href = '/use/reserve?' + result;
		
	});

	// 추천하기
	$("[id^='recommend']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(9,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

// 		console.log(result);
		location.href = '/use/recommend?' + result;
		
	});
</script>
	
	<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	

</body>
</html>