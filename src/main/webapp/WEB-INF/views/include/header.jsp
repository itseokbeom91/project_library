<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>

<!-- css  -->
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all">


<header>
	<div id="login">
		<c:choose>
		<c:when test="${ not empty id }">
			<a href="/member/logout">로그아웃</a>
			 |  <a href="/member/update?id=${ id }">회원정보수정</a>
		</c:when>
		<c:otherwise>
			<a href="/member/login">로그인</a>
			 | <a href="/member/join">회원가입</a>
		</c:otherwise>
		</c:choose>

	</div>
	<nav id="navbar">
		<div class="navbar_logo">
            <a href="/">전자</a> <i class="fas fa-book-reader"></i> 
            	<div class="navbar_logo1">
            <a href="/">도서관</a>
            </div>
	    </div>
	
		<ul class= "navbar_menu">
			<li>
				<c:choose>
				<c:when test="${ not empty id }">
					<a href="/my/mypage?id=${ id }">내서재</a>
				</c:when>
				<c:otherwise>
					<a href="/member/login">내서재</a>
				 </c:otherwise>
		 		</c:choose>
			</li>
			<li><a href="/book/list">전자책</a></li>
			<li><a href="/board/notice">알고싶어요</a></li>
			<li><a href="/board/announce/notice">공지사항</a></li>
			<li><a href="/chat/list">희망도서신청(채팅)</a></li>
		</ul>
		
        <a href="#" class="navbar_toogleBtn">
        	<i class="fas fa-bars"></i>
        </a>
		
	</nav>
		<div id="table_search">
		<form action="/book/list" method="get">
		
				<select name="category">
					<option value="publisher" ${ pageDto.category eq 'publisher' ? 'selected' : '' }>출판사</option>
					<option value="bookName" ${ pageDto.category eq 'bookName' ? 'selected' : '' }>도서명</option>
					<option value="writer" ${ pageDto.category eq 'writer' ? 'selected' : '' }>저자</option>
				</select>
					<input type="text" class="input_box" name="search" value="">
					<input type="submit" value="검색" class="tableSearch__btn">
			</form>
		</div>
</header>



