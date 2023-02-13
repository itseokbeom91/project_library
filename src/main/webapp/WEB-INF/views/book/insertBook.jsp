<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>

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
 
th{
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

</style>
<meta charset="UTF-8">
<title>전자도서관</title>
 <link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
</head>
<body>
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" />

	<div id="wrap">
	
		<h3><div style= "border:1px solid lightgray; padding: 15px; margin-bottom: 32px;">
				<span style="font-weight:bold;">도서 등록</span>
			</div>
		</h3>
	
		<form action="/book/insert" method="post" enctype="multipart/form-data">
			<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;" >
				<table id="notice">
					<tr>
						<th>표지사진</th>
						<td>
							<input type="file" name=file>
						</td>
					</tr>
					<tr>
						<th>종류</th>
						<td>
							<select name="sort">
								<option value="교과관련도서">교과관련도서</option>
								<option value="문학">문학</option>
								<option value="에세이/산문">에세이/산문</option>
								<option value="인문">인문</option>
								<option value="역사">역사</option>
								<option value="종교">종교</option>
								<option value="사회">사회</option>
								<option value="경제/비즈니스">경제/비즈니스</option>
								<option value="자연/과학">자연/과학</option>
								<option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
								<option value="어린이">어린이</option>
								<option value="외국어">외국어</option>
								<option value="수험서/자격증">수험서/자격증</option>
								<option value="취미/여행">취미/여행</option>
								<option value="문화/예술">문화/예술</option>
								<option value="가정/생활">가정/생활</option>
								<option value="만화">만화</option>
								<option value="대학교재">대학교재</option>
								<option value="자기계발">자기계발</option>
								<option value="기타미분류">기타미분류</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>출판사</th>
						<td>
<!-- 							<input type="text" name="publisher" id="publisher"> -->
							<textarea rows="1" cols="110" name="publisher" class="text-area"></textarea>
						</td>
					</tr>
					<tr>
						<th>출판년도</th>
						<td>
							<input type="date" name="birth">
						</td>
					</tr>
					<tr>
						<th>도서명</th>
						<td>
<!-- 							<input type="text" name="bookName"> -->
							<textarea rows="1" cols="110" name="bookName" class="text-area"></textarea>
						</td>
					</tr>
					<tr>
						<th>저자</th>
						<td>
<!-- 							<input type="text" name="writer"> -->
							<textarea rows="1" cols="110" name="writer" class="text-area"></textarea>
						</td>
					</tr>
					<tr>
						<th>저자소개</th>
						<td>
							<textarea rows="8" cols="110" name="introduceWriter" class="text-area"></textarea>
						</td>
					</tr>
					<tr>
						<th>목차</th>
						<td>
							<textarea rows="5" cols="110" name="neckKick" class="text-area"></textarea>
						</td>
					</tr>
					<tr>
						<th>책소개</th>
						<td>
							<textarea rows="15" cols="110" name="introduceBook" class="text-area"></textarea>
						</td>
					</tr>
				</table>
				<div id="modi_btns_1">
					<p><input type="submit" value="도서 등록" class="btn1"></p>
				</div>
			</div>
		</form>
	</div>
<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>