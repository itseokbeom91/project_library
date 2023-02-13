<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside id="sideBar">  
	
	<fieldset class ="l_main_login" >
	<c:choose>
	
	<c:when test="${ not empty id }">
		<p class = "p_main_login">
			<div class="hello"><strong>${ id }</strong>님 환영합니다.</div>
		
		<p class="login_my">대출(${ strBorrowCount }/5) 예약(${ strReserveCount }/5)</p>
		<c:set var="admin" value="admin"/>
		<c:choose>
		<c:when test="${ id eq admin }">
			<p class="p_btn_login"><input type="button" value="도서등록" onclick="location.href='/book/insert'"></p>
		</c:when>
		<c:otherwise>
			<p class="p_btn_login"><input type="button" value="내서재" onclick="location.href='/my/mypage?id=${ id }'"></p>
		</c:otherwise>
		</c:choose>
		
	</c:when>
	
	<c:otherwise>
		<form action="/member/login" method="post" id="sideBar_login">
		
			<ul class = "ul_main_login">
				<ul>
					<li><input type="text" id ="l_login_id" class="input_txt" name="id" title="아이디를 입력하세요" placeholder="아이디"></li>
					<li><input type="password" id="l_login_password" class="input_txt" name="passwd" title="패스워드를 입력하세요" placeholder="패스워드" ></li>
				</ul>
				<ul>
					<li class="l_btn_login"><input type="submit" id= "l_login_submit" value="로그인" class="submit"></li>
				</ul>
			</ul>
			<p class = "login_link">
				<a href="/member/idSearch">아이디 찾기 /</a>
				<a href="/member/passwordSearch">비밀번호 찾기</a>
			</p>
		
		</form>
	</c:otherwise>
	</c:choose>
	</fieldset>
		
	
<div id="booklist">
	
	<h3>전자책 분류</h3>
	
	<ul class="booklist__top" >
		<li style="border-bottom: 2px solid #e4e4e4;"><a href="/book/newBooks">신간</a></li>
		<li style="border-bottom: 2px solid #e4e4e4;"><a href="/book/bestBooks">베스트</a></li>
		<li style="border-bottom: 2px solid #e4e4e4;"><a href="/book/list">전자책 전체</a></li>
	</ul>
	<ul class="booklist_bottom">
		<li><a href="/book/list?category=sort&search=교과관련도서">교과관련도서</a></li>
		<li><a href="/book/list?category=sort&search=문학">문학</a></li>
		<li><a href="/book/list?category=sort&search=에세이/산문">에세이/산문</a></li>
		<li><a href="/book/list?category=sort&search=인문">인문</a></li>
		<li><a href="/book/list?category=sort&search=역사">역사</a></li>
		<li><a href="/book/list?category=sort&search=종교">종교</a></li>
		<li><a href="/book/list?category=sort&search=사회">사회</a></li>
		<li><a href="/book/list?category=sort&search=경제/비즈니스">경제/비즈니스</a></li>
		<li><a href="/book/list?category=sort&search=자연/과학">자연/과학</a></li>
		<li><a href="/book/list?category=sort&search=컴퓨터/인터넷">컴퓨터/인터넷</a></li>
		<li><a href="/book/list?category=sort&search=어린이">어린이</a></li>
		<li><a href="/book/list?category=sort&search=외국어">외국어</a></li>
		<li><a href="/book/list?category=sort&search=수험서/자격증">수험서/자격증</a></li>
		<li><a href="/book/list?category=sort&search=취미/여행">취미/여행</a></li>
		<li><a href="/book/list?category=sort&search=문화/예술">문화/예술</a></li>
		<li><a href="/book/list?category=sort&search=가정/생활">가정/생활</a></li>
		<li><a href="/book/list?category=sort&search=만화">만화</a></li>
		<li><a href="/book/list?category=sort&search=대학교재">대학교재</a></li>
		<li><a href="/book/list?category=sort&search=자기계발">자기계발</a></li>
		<li><a href="/book/list?category=sort&search=기타미분류">기타미분류</a></li>
	</ul>
</div>
</aside> 

