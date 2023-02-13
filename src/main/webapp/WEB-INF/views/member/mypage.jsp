<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all">

<title>전자도서관</title>
 <link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
<style>
* {
	padding: 0;
	margin: 0;
	list-style: none;
} 
.book_btn__content1 {
	margin-top: 20px;
	margin-right:50px;
	display: flex;
	flex-direction: column;
	float: right;
}
.book_btn__content2{
	margin-top: 70px;
	margin-right:50px;
	display: flex;
	flex-direction: column;
	float: right;
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
.book_btn__content1 input[type="button"]:hover{
	color:white;
	background-color: #4C94F1;
	border:1px solid lightgray; 
}

.book_list__content1 li .book_info li.text {
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
.text__content1 , .text__content2{
	display: -webkit-box; 
	margin: 10px 0 0 0;
    font-size: 14px;
    color: #999;
}
.inner_info__content1 , .inner_info__content2{
	color: #666;
    font-size: 14px;
	margin: 0 0 5px 0;
}


.inner_info__content1 span , .inner_info__content2 span{
	display: inline-block;
    margin: 0 2px 0 0;
    padding: 2px 7px 0 0;
    line-height: 12px;
    border-right: solid 2px #d4d5d6;
}

label i{
	color:#E85A00;
}
</style>

</head>
<body>

<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 

<div id="wrap">
	<h3>
		<div style= "border:1px solid lightgray; padding:15px;">
		<ul style="display: flex; justify-content: space-between;">
			<li><span style="font-weight:bold;">내 서재(${ id }님의 마이페이지)</span></li>
				<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
			<c:if test="${ not empty sessionScope.id }">
				<li><input type="button" value="회원정보수정" class="btn" style=" border-radius:0px; margin:0 10px 0 0; height: 29px; width: 85px;"onclick="location.href='/member/update?id=${ id }'"></li>
			</c:if>
		</ul>
		</div>
	</h3>

	<div class="main" style="text-align: left">

	<input id="tab1" type="radio" name="tabs" checked>
	<label for="tab1">대출중인도서</label>
	
	<input id="tab2" type="radio" name="tabs">
	<label for="tab2">예약중인도서</label>
	
	<input id="tab3" type="radio" name="tabs">
	<label for="tab3">대출이력</label>
	
	<input id="tab4" type="radio" name="tabs">
	<label for="tab4">알림</label>
	
	<input id="tab5" type="radio" name="tabs">
	<label for="tab5"><i class="fas fa-star"></i> 찜 한 도서</label>

<input type="hidden" id="memberId" value="${ id }">
	<section id="content1">
	<!-- 대출 현황 -->
		<div id="bookContent_sy" style="margin-bottom: 40px;">
			<c:choose>
				<c:when test="${ not empty borrowList }">
				<c:forEach var="borrow" items="${ borrowList }">
				
<%-- 				<c:forEach var="date" items="${ borrowDateList }"> --%>
				
					<input type="hidden" name="borrowNum" id="borrowNum" value="${ borrow.num }">
					<ul class="bookList" width="898" height="182">	
						<div class="book_img">
							<c:if test="${ not empty borrow.cover }">
								<a href="/book/content?num=${ borrow.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ borrow.cover }" width="82" height="112"></a>
							</c:if>
						</div>
					<ul class="book_info" >
						<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0;" width="49" height="18">[${ borrow.sort }]</li>
						<li class="subject"><a href="/book/content?num=${ borrow.num }&pageNum=${ pageNum }">${ borrow.bookName }</a></li>
						<li class="inner_info__content1"><span>${ borrow.publisher }</span>
							<span>${ borrow.writer }</span>
							<span>${ borrow.birth }</span>
							<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
						</li>
						
						 <li class="text__content1">
						 	대출일 : <fmt:formatDate value="${ borrow.borrowVo.borrowDate }" pattern="yyyy.MM.dd"/>
						 <br>
							 <li style="color:#32A7DC; font-size: 14px;" margin-bottom:5px;">
							 	반납일 : <fmt:formatDate value="${ borrow.borrowVo.overDate }" pattern="yyyy.MM.dd"/><li></li>
					</ul>
					</ul>
					<ul class="book_btn__content1">
						<input type="button" value="책읽기"  >
						<input type="button" value="반납하기" id="returnBorrow${ borrow.num }" >
					</ul>
					
						<hr>
<%-- 					</c:forEach> --%>
			</c:forEach>
			</c:when>
					<c:otherwise>
						대출중인 도서 없음
					</c:otherwise>
			</c:choose>
		</div>
		
	</section>

	<section id="content2">
	<!-- 예약 현황 -->
		<div id="bookContent_sy" style="margin-bottom: 40px;">
			<c:choose>
				<c:when test="${ not empty reserveList }">
				<c:forEach var="reserve" items="${ reserveList }">
					<input type="hidden" name="reserveNum" id="reserveNum" value="${ reserve.num }">
					<ul class="bookList" width="898" height="182">	
						<div class="book_img">
							<c:if test="${ not empty reserve.cover }">
								<a href="/book/content?num=${ reserve.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ reserve.cover }" width="82" height="112"></a>
							</c:if>
						</div>
					<ul class="book_info__content2" >
						<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0;" width="49" height="18">[${ reserve.sort }]</li>
						<li class="subject"><a href="/book/content?num=${ reserve.num }&pageNum=${ pageNum }">${ reserve.bookName }</a></li>
						<li class="inner_info__content2"><span>${ reserve.publisher }</span>
							<span>${ reserve.writer }</span>
							<span>${ reserve.birth }</span>
							<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
						</li>
						
						 <li class="text__content2">
						 	예약일 : <fmt:formatDate value="${ reserve.reserveVo.reserveDate }" pattern="yyyy.MM.dd"/>
						 <br>
						 	<li style="color:#32A7DC; font-size: 14px;" margin-bottom:5px;">
						 		대출예정일 : <fmt:formatDate value="${ reserve.reserveVo.overDate }" pattern="yyyy.MM.dd"/><li></li>
					</ul>
					</ul>	
					<ul class="book_btn__content2">
						<input type="button" value="예약취소" id="returnReserve${ reserve.num }" style="display: block;">
					</ul>
				
						<hr>
			</c:forEach>
			</c:when>
					<c:otherwise>
						예약중인 도서 없음
					</c:otherwise>
			</c:choose>
		</div>
		
	</section>
	
	<section id="content3">
	
	<div id="bookContent_sy" style="margin-bottom: 40px;">

		<c:choose>
			<c:when test="${ not empty totalBorrwoList }">
			<c:forEach var="totalBorrwo" items="${ totalBorrwoList }">
					<input type="hidden" name="totalBorrowNum" id="totalBorrowNum" value="${ totalBorrwo.num }">
				<ul class="bookList" width="898" height="182">	
					<div class="book_img">
						<c:if test="${ not empty totalBorrwo.cover }">
							<a href="/book/content?num=${ totalBorrwo.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ totalBorrwo.cover }" width="82" height="112"></a>
						</c:if>
					</div>
				<ul class="book_info" >
					<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0;" width="49" height="18">[${ totalBorrwo.sort }]</li>
					<li class="subject"><a href="/book/content?num=${ totalBorrwo.num }&pageNum=${ pageNum }">${ totalBorrwo.bookName }</a></li>
					<li class="inner_info"><span>${ totalBorrwo.publisher }</span>
						<span>${ totalBorrwo.writer }</span>
						<span class="end" style="border:none;">${ totalBorrwo.birth }</span>
					</li>
					<li class="inner_info"><span><strong>대출  ${ totalBorrwo.borrowCount } /5</strong></span>
						<span><strong>예약  ${ totalBorrwo.reserveCount } /5</strong></span>
						<span><strong>누적 대출  ${ totalBorrwo.totalBorrow }</strong></span>
						<span><strong>추천  ${ totalBorrwo.recommendCount }</strong></span>
						<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
					</li>
					<li class="text">${ totalBorrwo.introduceBook }</li>
				</ul>
				<ul class="book_btn">
						<c:choose>
							<c:when test="${ totalBorrwo.borrowCount lt 5 }">
								<input type="button" value="대출하기" id="borrow${ totalBorrwo.num }" style="display: block;">
								<input type="button" value="예약하기" id="reserve${ totalBorrwo.num }" style="display: none;">
							</c:when>
							<c:when test="${ totalBorrwo.borrowCount ge 5 and totalBorrwo.reserveCount lt 5 }">
								<input type="button" value="대출하기" id="borrow${ totalBorrwo.num }" style="display: none;">
								<input type="button" value="예약하기" id="reserve${ totalBorrwo.num }" style="display: block;">
							</c:when>
							<c:when test="${ totalBorrwo.reserveCount ge 5 }">
								<input type="button" value="대출하기" id="borrow${ totalBorrwo.num }" style="display: none;">
								<input type="button" value="예약하기" id="reserve${ totalBorrwo.num }" disabled="disabled">
							</c:when>
						</c:choose>
							
								<input type="button" value="추천하기" id="recommend${ totalBorrwo.num }">
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
	
	</section>
	
	<section id="content4">
	<!-- 알람 현황 -->
		<div id="bookContent_sy" style="margin-bottom: 40px;">
			<c:choose>
				<c:when test="${ not empty alarmList }">
				<c:forEach var="alarm" items="${ alarmList }">
					<input type="hidden" name="alarmNum" id="alarmNum" value="${ alarm.num }">
					<ul class="bookList" width="898" height="182">	
						<div class="book_img">
							<c:if test="${ not empty alarm.cover }">
								<a href="/book/content?num=${ alarm.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ alarm.cover }" width="82" height="112"></a>
							</c:if>
						</div>
					<ul class="book_info__content2" >
						<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0;" width="49" height="18">[${ alarm.sort }]</li>
						<li class="subject"><a href="/book/content?num=${ alarm.num }&pageNum=${ pageNum }">${ alarm.bookName }</a></li>
						<li class="inner_info__content2"><span>${ alarm.publisher }</span>
							<span>${ alarm.writer }</span>
							<span>${ alarm.birth }</span>
							<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
						</li>
						
						 <li class="text__content2">
						 	예약도서 자동대출 안내
						 <br>
						 	<li style="color:#32A7DC; font-size: 14px;" margin-bottom:5px;">
						 		<fmt:formatDate value="${ alarm.alarmVo.regDate }" pattern="yyyy년 MM월 dd일"/>에 자동대출되었습니다.<li></li>
					</ul>
					</ul>	
					<ul class="book_btn__content2">
						<input type="button" value="알림확인(삭제)" id="deleteAlarm${ alarm.num }" style="display: block;">
					</ul>
				
						<hr>
			</c:forEach>
			</c:when>
					<c:otherwise>
						알림 없음
					</c:otherwise>
			</c:choose>
		</div>
	
	</section>
	
	<section id="content5">
	
	<div id="bookContent_sy" style="margin-bottom: 40px;">

		<c:choose>
			<c:when test="${ not empty wishList }">
			<c:forEach var="wish" items="${ wishList }">
					<input type="hidden" name="wishNum" id="wishNum" value="${ wish.num }">
				<ul class="bookList" width="898" height="182">	
					<div class="book_img">
						<c:if test="${ not empty wish.cover }">
							<a href="/book/content?num=${ wish.num }&pageNum=${ pageNum }"><img alt="이미지 없음" src="/upload/${ wish.cover }" width="82" height="112"></a>
						</c:if>
					</div>
				<ul class="book_info" >
					<li class="inner_category"><img src="/images/eBook.gif" style="margin: 0px 3px 0 0;" width="49" height="18">[${ wish.sort }]</li>
					<li class="subject"><a href="/book/content?num=${ wish.num }&pageNum=${ pageNum }">${ wish.bookName }</a></li>
					<li class="inner_info"><span>${ wish.publisher }</span>
						<span>${ wish.writer }</span>
						<span class="end" style="border:none;">${ wish.birth }</span>
					</li>
					<li class="inner_info"><span><strong>대출  ${ wish.borrowCount } /5</strong></span>
						<span><strong>예약  ${ wish.reserveCount } /5</strong></span>
						<span><strong>누적 대출  ${ wish.totalBorrow }</strong></span>
						<span><strong>추천  ${ wish.recommendCount }</strong></span>
						<span class="end" style="border:none;">지원단말기:PC/스마트기기</span>
					</li>
					<li class="text">${ wish.introduceBook }</li>
				</ul>
				<ul class="book_btn">
						<c:choose>
							<c:when test="${ wish.borrowCount lt 5 }">
								<input type="button" value="대출하기" id="borrow${ wish.num }" style="display: block;">
								<input type="button" value="예약하기" id="reserve${ wish.num }" style="display: none;">
							</c:when>
							<c:when test="${ wish.borrowCount ge 5 and wish.reserveCount lt 5 }">
								<input type="button" value="대출하기" id="borrow${ wish.num }" style="display: none;">
								<input type="button" value="예약하기" id="reserve${ wish.num }" style="display: block;">
							</c:when>
							<c:when test="${ wish.reserveCount ge 5 }">
								<input type="button" value="대출하기" id="borrow${ wish.num }" style="display: none;">
								<input type="button" value="예약하기" id="reserve${ wish.num }" disabled="disabled">
							</c:when>
						</c:choose>
								<input type="button" value="추천하기" id="recommend${ wish.num }">
								<input type="button" value="찜하기 취소" onclick="location.href='/use/cancleWish?memberId=${ id }&bookNum=${ wish.num }'">
				</ul>
			</ul>	
					<hr>
		</c:forEach>
		</c:when>
				<c:otherwise>
					찜한 책 없음
				</c:otherwise>
		</c:choose>
	</div>
	
	</section>
</div>
</div>
<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>


	
	// 대출 반납하기
	$("[id^='returnBorrow']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(12,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

		location.href = '/my/returnBorrow?' + result;

	});


	// 예약 취소하기
	$("[id^='returnReserve']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(13,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

		location.href = '/my/returnReserve?' + result;

	});


	// 알림 확인하기
	$("[id^='deleteAlarm']").click(function(){

		var memberId = $('#memberId').val();
		console.log("memberId : " + memberId);
		
		var bookNum = $(this).attr('id').substring(11,this.length)
		console.log("bookNum : " + bookNum);

		var result = 'memberId=' + memberId + '&bookNum=' + bookNum;

		location.href = '/my/deleteAlarm?' + result;

	});


	
</script>
</body>
</html>