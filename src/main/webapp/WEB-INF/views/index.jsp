<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>
<title>전자도서관</title>
 <link rel="icon" type="image/png" href="/images/book-reader-solid.png" fillStyle="#BF815C">
 
 <script src="/script/jquery-1.6.1.min.js"></script>
<script src="/script/s3Slider.js"></script>

 <style>
 * {
    margin: 0;
    padding: 0;
    list-style: none;
}
#wrap_main{
margin: 30px 150px 0 26%;	



/* slide   */
}

#slider-wrap{
    width: 100%;
    height: 400px;
    position: relative;
    overflow: hidden;
}

#slider-wrap ul#slider {
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
}

#slider-wrap ul#slider li {
    float: left;
    position: relative;
    width: 600px;
    height: 400px;
}

#slider-wrap ul#slider li img {
    display: block;
    width: 100%;
    height: 100%;
}

/*btns*/
.slider-btns {
    position: absolute;
    width: 50px;
    height: 60px;
    top: 50%;
    margin-top: -25px;
    line-height: 57px;
    text-align: center;
    cursor: pointer;
    background: rgba(0, 0, 0, 0.1);
    z-index: 100;
    -webkit-user-select: none;
    -moz-user-select: none;
    -khtml-user-select: none;
    -ms-user-select: none;
    -webkit-transition: all 0.1s ease;
    -o-transition: all 0.1s ease;
    transition: all 0.1s ease;
}

.slider-btns:hover {
    background: rgba(0, 0, 0, 0.3);
}

#next {
    right: -50px;
    border-radius: 7px 0px 0px 7px;
    color: #eee;
}

#previous {
    left: -50px;
    border-radius: 0px 7px 7px 7px;
    color: #eee;
}

#slider-wrap.active #next {
    right: 0px;
}

#slider-wrap.active #previous {
    left: 0px;
}

/*bar*/
#slider-pagination-wrap {
    min-width: 20px;
    margin-top: 350px;
    margin-left: auto;
    margin-right: auto;
    height: 15px;
    position: relative;
    text-align: center;
}

#slider-pagination-wrap ul {
    width: 100%;
}

#slider-pagination-wrap ul li {
    margin: 0 4px;
    display: inline-block;
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: #fff;
    opacity: 0.5;
    position: relative;
    top: 0;
}

#slider-pagination-wrap ul li.active {
    width: 12px;
    height: 12px;
    top: 3px;
    opacity: 1;
    -webkit-box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
    box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
}

/*ANIMATION*/
#slider-wrap ul,
#slider-pagination-wrap ul li {
    -webkit-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
    -o-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
    transition: all 0.3s cubic-bezier(1, .01, .32, 1);
}
/*===============slide  end===================================== */


 #main_recommend{
display: flex;
justify-content: space-between;
border:solid 1px #d4d5d6;
margin: 0px 0 10px 0;
    padding: 10px 15px 0 15px;
       min-height: 190px;
         color: #666;
}

#main_recommend div {
display: flex;

}
.main_ul{
display: flex;
justify-content: space-between;
border:solid 1px #d4d5d6;
margin: 0px 0 10px 0;
    padding: 10px 15px 0 15px;
    height: 170px;
    
}

.main_ul h5{
text-align: center;
color: #666;
}

.bookImg_recommend{
width: 450px;
margin-bottom: 30px;

}

.main_inner_txt {
margin-left: 30px;
}

.main_book_int{
overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box; 
	-webkit-line-clamp: 5; 
	-webkit-box-orient: vertical; 

  
}

.main_guide_box li{
margin-left: 140px

}
.main_list_title {
    padding: 13px 20px 13px 20px;
    border: solid 1px #d4d5d6;
    border-bottom: none;
    /* position: relative; */
    background: #fff;
    display: flex;
    justify-content: space-between;
    margin-top:50px;
    background-color: #FFFFFF;
}

#main_ul ul{
  display: flex;
    justify-content: space-between;
    background-color: #FFFFFF;
}
.main_bookImg {
width: 152px;
text-align: center;
padding: 5px;

}

.main_list_title i{
color: #267AC2;
}

.titleLine {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box; 
	-webkit-line-clamp: 2; 
	-webkit-box-orient: vertical; 
}
.writerLine {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box; 
	-webkit-line-clamp: 1; 
	-webkit-box-orient: vertical; 

}

 </style>
</head>
<body>
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 

<div id="wrap_main">  
	<div id="slider-wrap">
		<ul id="slider">
			<li><img src="images/2.jpg"></li>
			<li><img src="images/5.jpg"></li>
			<li><img src="images/6.jpg"></li>
			<li><img src="images/4.jpg"></li>
			<li><img src="images/3.jpeg"></li>
		</ul>
		<div class="slider-btns" id="next"><span>▶</span></div>
    	<div class="slider-btns" id="previous"><span>◀</span></div>
    	<div id="slider-pagination-wrap">
	        <ul>
	        </ul>
	    </div>
	</div>

	<div class="main_list_title"><p>추천 도서</p></div>
	<div id="main_recommend">

	<div class="bookImg_recommend">
		<div class="main_bookImg_big"><a href="/book/content?num=${ bookVo.num }"><img src="/upload/${ bookVo.cover }" width="190" height="230"></a></div>
					<ul class="main_inner_txt">
						<h3><li style="font-weight: var(--weight-semi-bold); width: 280px;"><a href="/book/content?num=${ bookVo.num }">${ bookVo.bookName }</a></li></h3>
						<li style=" font-size: var(--font-micro);">저자 : <span><a href="">${ bookVo.writer }</a></span></li>
						<li style=" font-size: var(--font-micro); margin-bottom: 10px">출판사 : <span><a href="">${ bookVo.publisher }</a></span></li>
						<li class="main_book_int" style=" font-size: var(--font-micro); line-height: 20px;">${ bookVo.introduceBook }</li>					
					</ul>
	</div>
		
	<div class="main_guide_box" >
			    <hr style="color:#d4d5d6; margin-right: 30px;">
					<ul style="width:430px;">
					<h2 style=" text-align: center; margin-bottom: 20px; border-bottom: 2px solid #3d7ab1; padding-bottom: 20px;">대출규정안내</h2>
						
						<h3><li>- 대출권수: <strong style="color:#f26532">5권</strong></li></h3>
						<h3><li>- 대출기간: <strong style="color:#f26532">15일</strong></li></h3>
						<h3><li>- 연장횟수: <strong style="color:#f26532">0회</strong></li></h3>
						<h3><h3><li>- 도서별예약권수: <strong style="color:#f26532">5권</strong></li></h3>
					</ul>
			    </div>
	</div>
	
	<div class="main_list_title"><p>베스트 도서</p><a href="/book/bestBooks">더보기 <i class="fas fa-angle-right"></i></a></div>
	<div id="main_best">
	
			<ul class="main_ul">
			<li class="prev"><a href="/"><i class="fas fa-angle-left" style="font-size: 50px; margin-top:30px; color: #ccc;"></i></a></li>
			<c:choose>
				<c:when test="${ not empty bestBookList }">
					<c:forEach var="best" items="${ bestBookList }">
						<li style="width: 110px; height: 170px;">
							<a href="/book/content?num=${ best.num }">
								<img src="/upload/${ best.cover }" width="82px;" height="112px;" style="margin-left: auto; margin-right: auto; display: block;">
								<h5 class="titleLine">${ best.bookName }</h5>
								<h5 class="writerLine" style="font-weight: lighter">${ best.writer }</h5>
							</a>
						</li>
					</c:forEach>
				</c:when>
			</c:choose>
			<li class="next"><a href="/"><i class="fas fa-angle-right" style="font-size: 50px; margin-top:30px;  color: #ccc;"></i></a></li>
			</ul>
			
	   
		
	</div>
	<div class="main_list_title"><p>신착 도서</p><a href="/book/newBooks">더보기 <i class="fas fa-angle-right"></i></a></div>
	<div id="main_new">
	
			<ul class="main_ul">
			<li class="prev"><a href="/"><i class="fas fa-angle-left" style="font-size: 50px; margin-top:30px;  color: #ccc;"></i></a></li>
			<c:choose>
				<c:when test="${ not empty newList }">
					<c:forEach var="new" items="${ newList }">
						<li style="width: 110px; height: 170px;">
							<a href="/book/content?num=${ new.num }">
								<img src="/upload/${ new.cover }" width="82px;"height="112px;" style="margin-left: auto; margin-right: auto; display: block;">
								<h5 class="titleLine">${ new.bookName }</h5>
								<h5 class="writerLine" style="font-weight: lighter" >${ new.writer }</h5>
							</a>
						</li>
					</c:forEach>
				</c:when>
			</c:choose>
			<li class="next"><a href="/"><i class="fas fa-angle-right" style="font-size: 50px; margin-top:30px;  color: #ccc;"></i></a></li>
			</ul>
	</div>






	<!--  <input type="button" value="도서 리스트" onclick="location.href='/book/list'"> -->
<%-- <c:choose>  --%>
<%--  <c:when test="${ id eq 'admin' }">	 --%>
<!-- 		<input type="button" value="도서 등록" onclick="location.href='/book/insert'"> -->
<%-- 	</c:when> --%>
<%--  </c:choose>  --%>
 <%-- <c:choose>
	<c:when test="${ not empty id }">
		<input type="button" value="로그아웃" onclick="location.href='/member/logout'">
		<input type="button" value="${ id }님의 서재" onclick="location.href='/my/mypage?id=${ id }'">
	</c:when>
	<c:otherwise>
		<input type="button" value="회원가입" onclick="location.href='/member/join'">
		<input type="button" value="로그인" onclick="location.href='/member/login'">
		<input type="button" value="아이디 찾기" onclick="location.href='/member/idSearch'">
		<input type="button" value="비밀번호 찾기" onclick="location.href='/member/passwordSearch'">
	</c:otherwise>
</c:choose>   --%>
 
	
</div>

<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
	
	//slide-wrap
	var slideWrapper = document.getElementById('slider-wrap','main_best');
	//current slideIndexition
	var slideIndex = 0;
	//items
	var slides = document.querySelectorAll('#slider-wrap ul li', '#main_best ul li');
	//number of slides
	var totalSlides = slides.length;
	//get the slide width
	var sliderWidth = slideWrapper.clientWidth;
	//set width of items
	slides.forEach(function (element) {
	    element.style.width = sliderWidth + 'px';
	})
	//set width to be 'x' times the number of slides
	var slider = document.querySelector('#slider-wrap ul#slider', '#main_best ul#slider');
	slider.style.width = sliderWidth * totalSlides + 'px';

	// next, prev
	var nextBtn = document.getElementById('next');
	var prevBtn = document.getElementById('previous');
	nextBtn.addEventListener('click', function () {
	    plusSlides(1);
	});
	prevBtn.addEventListener('click', function () {
	    plusSlides(-1);
	});

	// hover
	slideWrapper.addEventListener('mouseover', function () {
	    this.classList.add('active');
	    clearInterval(autoSlider);
	});
	slideWrapper.addEventListener('mouseleave', function () {
	    this.classList.remove('active');
	    autoSlider = setInterval(function () {
	        plusSlides(1);
	    }, 3000);
	});


	function plusSlides(n) {
	    showSlides(slideIndex += n);
	}

	function currentSlides(n) {
	    showSlides(slideIndex = n);
	}

	function showSlides(n) {
	    slideIndex = n;
	    if (slideIndex == -1) {
	        slideIndex = totalSlides - 1;
	    } else if (slideIndex === totalSlides) {
	        slideIndex = 0;
	    }

	    slider.style.left = -(sliderWidth * slideIndex) + 'px';
	    pagination();
	}

	//pagination
	slides.forEach(function () {
	    var li = document.createElement('li');
	    document.querySelector('#slider-pagination-wrap ul').appendChild(li);
	})

	function pagination() {
	    var dots = document.querySelectorAll('#slider-pagination-wrap ul li');
	    dots.forEach(function (element) {
	        element.classList.remove('active');
	    });
	    dots[slideIndex].classList.add('active');
	}

	pagination();
	var autoSlider = setInterval(function () {
	    plusSlides(1);
	}, 3000);
	    
	
	/*==========================================================  */
	
	
	
	

	
</script>
</body>
</html>