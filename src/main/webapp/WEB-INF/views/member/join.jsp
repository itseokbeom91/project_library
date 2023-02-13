<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자도서관</title>
<link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
<style>

#join fieldset{
	min-height: 400px;
	margin-top: 45px
}

.join_content{
/*  text-align: center; */
margin-left: 300px;
}

.join_content  label{
	margin:0px;
	padding:0px;
	color:#4d4d4d;
	font-weight: 700;
	margin-top: 10px;
}

.value, .pass, .id, .mobile{
	width: 461px;
	height: 53px;
	padding-left: 13px;
}

.btnJoin {
	text-align:center;
	width: 478px;
    height:	60px;
	padding:8px; 
	margin-top:40px;
	margin-bottom:20px;
	background-color: #267AC2;
	color:white;
	border: 2px solid #267AC2;
	 font-size: var(--font-regular);
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
		<span style="font-weight:bold;">회원가입</span>
		</div>
	</h3>
	<form id="join" action="/member/join" method="post" name="frm">
		<fieldset style="border:2px solid lightgray; padding: 15px;">
			
			<div class="join_content">
			
				<h3><label>아이디</label></h3>
				<input type="text" name="id" class="id" required>
				<div id="msgIdDup"></div><br> 
				
				<h3><label>비밀번호</label></h3>
				<input type="password" name="passwd" class="pass pass1" required><br>
	
				<h3><label>비밀번호 확인 </label></h3>
				<input  type="password" class="pass pass2" required>
				<div id="msgPass"></div> <br>
	
				<h3><label>이름</label></h3>
				<input type="text" name="name" class="value" id="name" required>
				
				<h3><label>E-Mail</label></h3>
				<input type="email" name="email" class="value" id="email" required>
													
				<h3><label>주소</label></h3>
				<input style="width:42.5%; margin-bottom: 10px;"  class="value"   placeholder="우편번호" name="oAddress" readonly="readonly" > 
				<button style="height:57px; margin-left: 6px;  border: 2px solid #267AC2; color:white; background-color: #267AC2; padding:0 11px;" 
						type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search">우편번호 찾기</i></button><br>
				
				
				<input style=" margin-bottom: 10px;"  placeholder="도로명 주소" type="text" name="address"  class="value" readonly="readonly"><br> 
				
			
				<input type="text" placeholder="상세주소" name="detailAddress" class="value"><br>
				
				<h3><label style="margin-top: 15px;">휴대전화</label></h3>
				<input type="tel" name="tel" class="value" required  placeholder="(-)없이 입력해주세요."><br> 
				
				<h3><label>나이</label></h3>
				<input type="number" name="age" min="0" max="200" class="mobile" required><br>
	
				<h3><label>성별</label></h3>
				<input type="radio" name="gender" value="남" style="display: inline;" required> 남성
				<input type="radio" name="gender" value="여" style="display: inline;"> 여성 <br>
				
			
				<div class="clear"></div>
				<div id="join--buttons">
					<input class="btnJoin" type="submit" value="회원가입" class="submit"><br>
				<!-- 	<input class="btnReset"type="reset" value="초기화" class="cancel"> -->
				</div>
			</div>
		</fieldset>

		
	</form>

</article>



</div>
<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>

<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
td {
	border: 1px solid #000000;
	border-collapse: collapse;
}
</style>


<script>

	// 아이디 중복체크	
	$('input[name="id"]').keyup(function () {
		var id = $(this).val();
	
		if (id.length <= 2) { // 아이디 두글자 까지는 중복체크 안함
			return;
		}
	
		// 아이디 세글자 부터는 Ajax로 아이디 중복체크하기
		$.ajax({
			url: '/member/ajax/joinIdDupChk',
			data: { id: id },
			//method: 'GET',
			success: function (data) {
				console.log(typeof data);
				console.log(data);
	
				if (data == 1) {
					$('div#msgIdDup').html('이미 사용중인 아이디 입니다.').css('color', 'red');
				} else {
					$('div#msgIdDup').html('사용 가능한 아이디 입니다.').css('color', 'green');
				}
			}
		});
	});


	
	// 비밀번호 일치여부
	$('.pass2').focusout(function () {
		let pass1 = $('.pass1').val();
		let pass2 = $(this).val();
	
		if (pass1 == pass2) {
			$('#msgPass').html('비밀번호가 일치합니다.').css('color', 'green');
		} else {
			$('#msgPass').html('비밀번호가 일치하지 않습니다.').css('color', 'red');
		}
	});
	
	//우편번호 찾기 버튼 클릭시 발생 이벤트 
	function execPostCode() {
		new daum.Postcode({ 
			oncomplete: function(data) { 
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 
				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다. 
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다. 
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수 
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수 
				
				// 법정동명이 있을 경우 추가한다. (법정리는 제외) 
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. 
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){ 
					extraRoadAddr += data.bname; } 
				// 건물명이 있고, 공동주택일 경우 추가한다. 
				if(data.buildingName !== '' && data.apartment === 'Y'){ 
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName); } 
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다. 
				if(extraRoadAddr !== ''){ extraRoadAddr = ' (' + extraRoadAddr + ')'; } 
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다. 
				if(fullRoadAddr !== ''){ fullRoadAddr += extraRoadAddr; } 
				 
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode); 
				console.log(fullRoadAddr); 
				
				/* var a = console.log(data.zonecode); 
				   var b = console.log(fullRoadAddr); 
				if(a == null || b = null){ alert("주소를 확인하세요."); return false; } */ 
				
				$("[name=oAddress]").val(data.zonecode); 
				$("[name=address]").val(fullRoadAddr); 
				
				document.getElementById('oAddress').value = data.zonecode; //5자리 새우편번호 사용 
				document.getElementById('address').value = fullRoadAddr; 
			} 
	}).open(); 
	}


</script>
</body>
</html>

