<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fontawesome  -->
<script src="https://kit.fontawesome.com/0b588c2a50.js" crossorigin="anonymous"></script>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all">

<title>전자도서관</title>
 <link rel="icon" type="image/png" href="images/book-reader-solid.png" fillStyle="#BF815C">
<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 


<style>

 * {
	padding: 0;
	margin: 0;
	list-style: none;
} 

#bookContent_sy{
	border:1px solid lightgray; 
	padding: 45px;
	background-color: #FFFFFF;
}

#bookContent_sy ul{
	margin: 0 12px 7px 0;
}
section {
padding: 20px 30px;

}
.title {
	margin: 0 0 28px 0;
	font-weight: bold;
}

#bookDetail_sy {
	display: inline-block;
	display: flex;
	position: relative;
	margin: 0 0 40px 0px;
}

.book_img {
	margin-right: 5%;
}

.bookInfo_sy h4 {
	font-weight: var(--weight-regular);
	color: #666;
	word-spacing: 10px;
}

#bookAvailability_sy {
	 display: flex;
 }
 
 #bookAvailability_sy li{
    margin: 5px 25px 10px 0 ; 
    font-size: 23px;
    font-weight: bold;
 }
span{
	display: inline-block;
    margin: 0 8px 0 0;
    padding: 2px 7px 0 0;
    line-height: 18px;
/*     border-right: solid 2px #d4d5d6; */
}
#btn_sy {
	display: flex;
}

#btn_sy button.o{
 	margin-right: 18px;
    width: 120px;
    height: 39px;
    border:1px solid lightgray; 
   	font-weight: bold;
   	color: #4d4d4d;
   	background-color: #eeeeee;
   	margin-top: 50px;
    border-radius: 4px;
}

#btn_sy .o:hover{
color:white;
background-color: #4C94F1;
border:1px solid lightgray; 
}

button i{
	color:#E85A00;
}

#star a{
    text-decoration: none;
    color: gray;
}
#star a.on{
    color: red;
}

.content_review{

display: flex;

}



.addReview{
	font-size: var(--font-regular);
	text-align:center;
	width: 130px;
    height:	76px;
	padding:0px; 
	margin-left: 10px;  
	background-color: #267AC2;
	color:white;
	border: 2px solid #267AC2;
}
.addReview:disabled {
	font-size: var(--font-regular);
	text-align:center;
	width: 130px;
    height:	76px;
	padding:0px; 
	margin-left: 10px;  
	background-color: skyblue;
	color:lightblue;
	border: 2px solid skyblue;
	cursor: default;
}


textarea::placeholder {
	
	padding: 10px 0 0 17px ;
	color: #999; 
	font-weight: var(--weight-regular);
	
}

textarea {
color:#267AC2;	
border:solid 1px #267AC2;
background-color:#f8f8f8;
	
}

span.moDe {
cursor: pointer;
}

pans.moDe:hover {
	text-decoration: underline;
}

.disabled {
display: none;
}

.x {
	cursor: default;
	margin-right: 18px;
    width: 120px;
    height: 39px;
    border:1px solid #F5F5F7; 
   	font-weight: bold;
   	color: #D5D5D8;
   	background-color: #F5F5F7;
   	margin-top: 50px;
    border-radius: 4px;
}
</style>
</head>
<body>
<div id="wrap">
	<div id="bookContent_sy">
		<h2 class="title"><img src="/images/eBook.gif" style= "margin: -4px 10px 0 0; " >${ bookVo.bookName }</h2>
		<div id="bookDetail_sy">
			<div class="book_img">
				<img alt="" src="/upload/${ bookVo.cover }" width="200" height="290">
			</div>
			
			<div id="bookRight_sy">
				<ul class="bookInfo_sy">
				<h4>
					<li>저   자: ${ bookVo.writer }</li>
					<li>출판사: ${ bookVo.publisher }</li>
					<li>출판일: ${ bookVo.birth }</li>
				</h4>
				</ul>
				
				<ul id="bookAvailability_sy">
					<li class="inner_info"><span><strong>대출  ${ bookVo.borrowCount }  /5</strong></span>
					<span><strong>예약 ${ bookVo.reserveCount } /5</strong></span>
					<span><strong>누적 대출  ${ bookVo.totalBorrow }</strong></span>
					<span class="end" style="border:none;"><strong>추천  ${ bookVo.recommendCount }</strong></span>
					
				</li>
				</ul>
				
				<h5 style="color: #666; font-weight: var(--weight-regular); margin-bottom: 9px;" >지원단말기 :PC/스마트기기</h5><br>
				
				<ul id="btn_sy">
					<li>
					<c:choose>
						<c:when test="${ bookVo.borrowCount ge 5 }">
							<button class="x" disabled="disabled">대출하기</button>
						</c:when>
						<c:otherwise>
							<button onclick="location.href='/use/borrow?memberId=${ id }&bookNum=${ bookVo.num }'" class="o">대출하기</button>
						</c:otherwise>
					</c:choose>
					</li>
					<li>
					<c:choose>
						<c:when test="${ bookVo.reserveCount ge 5 }">
							<button class="x" disabled="disabled">예약하기</button>
						</c:when>
						<c:otherwise>
							<button onclick="location.href='/use/reserve?memberId=${ id }&bookNum=${ bookVo.num }'" class="o">예약하기</button>
						</c:otherwise>
					</c:choose>	
					</li>
					<li><button onclick="location.href='/use/recommend?memberId=${ id }&bookNum=${ bookVo.num }'" class="o">추천하기</button></li>
					<li><button onclick="location.href='/use/wish?memberId=${ id }&bookNum=${ bookVo.num }'" class="o"><i class="fas fa-star"></i> 찜하기</button></li>
				</ul>
			</div>
		</div>


		<div class="main" style="text-align: left">

			<input id="tab1" type="radio" name="tabs" checked>
			<label for="tab1">책소개</label>
			
			<input id="tab2" type="radio" name="tabs">
			<label for="tab2">저자소개</label>
			
			<input id="tab3" type="radio" name="tabs">
			<label for="tab3">목차</label>
			
			<input id="tab4" type="radio" name="tabs">
			<label for="tab4">한줄평</label>
			
			
		
			<section id="content1">
				<div>${ bookVo.introduceBook }</div>
		
			</section>
		
			<section id="content2">
				<div>${ bookVo.introduceWriter }</div>
		
			</section>
			
			<section id="content3">
				<div >${ bookVo.neckKick }</div>
			</section>
			
			<section id="content4">
				<div>
<!-- 			<p id="star"> -->
<!-- 		        <a href="#">★</a> -->
<!-- 		        <a href="#">★</a> -->
<!-- 		        <a href="#">★</a> -->
<!-- 		        <a href="#">★</a> -->
<!-- 		        <a href="#">★</a> -->
<!-- 		    </p> -->
					<div id="app">
						<!-- 주댓글 작성 영역 -->
						<div class="panel-footer">
							<ul class="content_review">
							<c:choose>
								<c:when test="${ not empty id }">
									<li><textarea style="resize: none;" rows="5" cols="110"  v-model="inputReview" name="content" placeholder="한글 기준 100자까지 작성 가능"  border= "solid 1px #ebebeb" background-color="#f8f8f8"></textarea></li>
								</c:when>
								<c:otherwise>
									<li><textarea style="resize: none;" rows="5" cols="110" disabled="disabled" border= "solid 1px #ebebeb" background-color="#f8f8f8">로그인 후 작성 가능합니다.</textarea></li>
								</c:otherwise>
							</c:choose>
							<br>
							<li><button type="button" v-on:click="addReview" class="addReview" v-bind:disabled="inputReview == '' || inputReview.length > 100 || ${ empty id }">등록</button>
							<small style="margin-left: 12px;">{{ remain }} / 100</small></li>
							</ul>
							<br>
						</div>
							
							
						<div class="panel-body">
							<!-- 댓글 리스트 영역 -->
							<ul class="media-list">
			
								<transition-group>
								<li style=" width:803px; border: solid 1px #ebebeb; background-color: #f8f8f8; margin-bottom: 20px;"
									v-for="(review, index) in reviewList"
									v-bind:key="review.rno">
		
									
			
									<div class="media-body">
										
										<h3 style="padding-left: 17px;">{{ review.content }}</h3>
										<h5>
										<span style="color:  #6699cc; padding-left:600px; border-right: solid 2px #d4d5d6;">{{ review.id }}</span>  {{ getDate(review.updateDate) }}
										<div v-if="review.id == loginId" style="padding-left: 705px;">
											<span class="moDe" v-on:click="toggleModify(index)" style="color: #6699cc">{{ review.writeOk ? '닫기' : '수정' }}</span>
											/
											<span class="moDe" v-on:click="removeReview(index, $event)" style="color: #6699cc">삭제</span>
										</div>
										</h5>
										<br>
									</div>
									
									<div v-if="review.writeOk" style="margin-left: 50px;">
										<ul class="content_review">
										<li><textarea v-model="inputModifyReview" rows="5" cols="80" class="form-control" placeholder="수정 내용을 입력하세요."
												  	style="resize: none;" border= "solid 1px #ebebeb" background-color="#f8f8f8"></textarea></li>
										<li><button type="button" class="addReview" v-on:click="modifyReview(index)" v-bind:disabled="inputModifyReview == '' || inputModifyReview.length > 100 || ${ empty id }">수정</button>
											<small class="text-muted" style="margin-left: 20px;">{{ modifyRemain }} / 100</small></li>
										</ul>
									</div>
									
									</li>
								</transition-group>
							</ul>
							
							<!-- 페이지 블록 영역 -->
							<ul v-if="totalCount > 0" id="page_control">
								<li class="div2" v-bind:class="{ 'disabled': !isPrevOk }">
									<a href="#" v-on:click="setPageNo(prevBlockPage)">«</a>
								</li>
								
								<li class="div2" v-for="item in pageBlockList" v-bind:key="item.pageNum" v-bind:class="{ 'active': item.isCurrentPage }">
									<a href="#" v-on:click="setPageNo(item.pageNum)">{{ item.pageNum }}</a>
								</li>
								
								<li class="div2" v-bind:class="{ 'disabled': !isNextOk }">
									<a href="#" v-on:click="setPageNo(nextBlockPage)">»</a>
								</li>
							</ul>
						</div>
						<div v-if="totalCount == 0"> 첫 한줄평을 남겨보세요! </div>
				    </div>
				</div>
			</section>
		</div>
	</div>
</div>

<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
<script src="/script/jquery-3.5.1.js"></script>
<script src="/script/bootstrap.js"></script>

<script>

	//게시글 번호
	const bno = ${ bookVo.num };
	
	new Vue({
		el: '#app',
		data: {
			loginId: '${ sessionScope.id }', // 톰캣서버 세션의 로그인 아이디
			pageNo: 1,  // 사용자 요청 페이지 번호
			totalCount: 0,    // 전체 리뷰 갯수
			reviewList: [],  // 리뷰 리스트 데이터
			inputReview: '', // 리뷰 입력내용
			inputModifyReview: '', // 수정 입력내용
			type: '',  // 댓글수정(update) 또는 답댓글 추가(insert) 인지 구분
	
			// 페이지블록 관련 데이터 속성
			numOfRows: 10, // 한 페이지당 보여지는 리뷰 갯수
			pageCount: 0,  // 총 페이지 갯수
			pageBlock: 5,  // 페이지블록 내의 페이지 갯수
			startPage: 0,  // 페이지블록 내의 시작페이지
			endPage: 0,    // 페이지블록 내의 끝페이지
			pageBlockList: [] // 페이지블록 리스트 (시작페이지부터 끝페이지까지의 페이지번호가 요소)
		},
		computed: {
			
			remain: function () { // 댓글입력 남은 글자수
				return 100 - this.inputReview.length;
			},

			modifyRemain: function () {
				return 100 - this.inputModifyReview.length;
			},
						
			isPrevOk: function () { // 이전 페이지블록 존재 여부
				return this.pageNo > 1;
			},
			
			isNextOk: function () { // 다음 페이지블록 존재여부
				return this.pageNo < this.pageCount;
			},
	
			prevBlockPage: function () {
				return this.pageNo - 1;
			},
	
			nextBlockPage: function () {
				return this.pageNo + 1;
			}
		},
		watch: {
			inputReview: function () {
				if (this.inputReview.length > 100) {
					this.inputReview = this.inputReview.substring(0, 100);
				}
			},

			inputModifyReview: function () {
				if (this.inputModifyReview.length > 100) {
					this.inputModifyReview = this.inputModifyReview.substring(0, 100);
				}
			}
		},
		methods: {

			// 시간 구하기
			getDate: function (str) {
	//				console.log('getDate type : ' + typeof str);
	//				console.log('getDate : ' + str);
	
				let today = new Date(); // 현재시점 날짜시간
				let date = new Date(str); // new Date('2021-01-06T02:44:32.000+00:00');
	
				let now = today.toLocaleDateString(); // 현재 연월일
				let reviewDate = date.toLocaleDateString(); // 등록일 연월일
	
				let result;
				
				if (now == reviewDate) { // 같은날에는 시간
					result = moment(str).format('a hh:mm:ss');
				} else { // 날짜 달라지면 연월일
					result = moment(str).format('YYYY-MM-DD');
				}
				
				return result;
			},
	
			setPageNo: function (pageNum) {
				if (pageNum < 1 || pageNum > this.pageCount) {
					return;
				}
				this.pageNo = pageNum;
				this.getList();
			},
			
			// 리뷰 목록 가져오기
			getList: function () {
				// jsp의 el언어로 게시판 글번호를 출력해서 자바스크립트 변수에 저장
				let vm = this; // ViewModel의 약칭. Vue객체 자기자신을 vm 변수로 저장
				
				$.ajax({
					url: '/review/pages/' + bno + '/' + this.pageNo + '/' + 5,
					method: 'GET',
	//					dataType: 'json',
					success: function (response) {
						console.log(typeof response);
						console.log(response);
							
						for (let review of response.reviewList) {
							review.writeOk = false; // 오브젝트마다 writeOk 필드 추가
							console.log(review);
						} // for
	
						vm.inputReview = '';  // 입력상자 비우기
						
						// 서버에서 응답받은 데이터를 리액티브 데이터에 저장
						// 리액티브 데이터가 변경되면 즉시 바인딩된 화면도 렌더링됨
						vm.reviewList = response.reviewList;
	
						// 전체 댓글 갯수
						vm.totalCount = response.totalCount;
	
						// 페이지블록 만들기 (전체댓글갯수를 기준으로 페이지블록 생성)
						vm.makePageBlock();
					},
					error: function () {
						alert('댓글 리스트 가져오기 오류 발생...')
					}
				});
			}, // getList
	
			// 페이지블록 만들기
			makePageBlock: function () {
				// 댓글의 총 페이지 갯수 구하기
				this.pageCount = Math.ceil( this.totalCount / 5 );
	
				// ((1-1) / 5) * 5 + 1  -> 1
				// ((5-1) / 5) * 5 + 1  -> 1
				
				// ((6-1)) / 5 * 5 + 1  -> 6
				// ((10-1)) / 5 * 5 + 1 -> 6
				
				// 페이지블록 내의 시작페이지 구하기
				this.startPage = Math.floor((this.pageNo - 1) / this.pageBlock) * this.pageBlock + 1;
	
				// 페이지블록 내의 끝페이지 구하기
				this.endPage = this.startPage + this.pageBlock - 1;
				if (this.endPage > this.pageCount) {
					this.endPage = this.pageCount;
				}
	
				// 페이지번호 배열리스트 비우기
				this.pageBlockList.splice(0);
	
				for (let i=this.startPage; i<=this.endPage; i++) {
					let obj = {
							pageNum: i,
							isCurrentPage: (this.pageNo == i) ? true : false 
					};
					
					this.pageBlockList.push(obj);
				} // for
				
			},
	
			
			// 리뷰 등록하기
			addReview: function () {
				let obj = {
						bno: bno,
						content: this.inputReview
				};
				console.log('addReview obj : ' + obj);
	
				let str = JSON.stringify(obj); // 자바스크립트 객체를 JSON 문자열로 변환
				console.log('addReview JSON : ' + str);

	
				let vm = this;
				
				$.ajax({
					url: '/review/new',
					data: str,
					method: 'POST',
					contentType: 'application/json; charset=UTF-8',
					success: function (response) {
						console.log(response);
	
						// 현재 페이지 다시 불러오기
						vm.getList();
						
					},
					error: function (req, status, err) {
						console.log('code: ' + req.status + '\n message: ' + req.responseText + '\n error: ' + err);
						console.log(typeof req.responseText); // string
	
						let obj = JSON.parse(req.responseText); // <-> JSON.stringify()
						console.log(typeof obj) // object
						
						if (obj.isLogin == false) {
							alert('로그인 사용자만 댓글 작성이 가능합니다.');
							location.href = '/member/login';
						}
					}
				});
			}, // addreview
	
	
			// 한개 삭제하기
			removeReview: function (index, event) {
				// a 태그의 href 속성 기본기능 방지
				event.preventDefault(); // 스크롤바 이동 방지
	
				let isRemove = confirm('댓글을 정말 삭제하시겠습니까?');
				if (isRemove == false) {
					return;
				}
				
				let review = this.reviewList[index];
				let rno = review.rno;
				console.log('삭제 rno = ' + rno);
	
				let vm = this;
				
				// 삭제 요청
				$.ajax({
					url: '/review/delete/' + rno,
					method: 'DELETE',
					success: function (response) {
						console.log(response);
						// 현재 페이지 다시 불러오기
						vm.getList();
	
					},
					error: function () {
						alert('로그인 사용자만 댓글 삭제가 가능합니다.');
						location.href = '/member/login';
					}
				});
			},
	
	
			// 수정 토글 열기
			toggleModify: function (index) {
				// 답댓글 입력내용 비우기
				this.inputModifyReview = '';
	
				for (let i=0; i<this.reviewList.length; i++) {
					let review = this.reviewList[i];
	
					// 클릭한 위치는 토글처리
					if (i == index) {
						if (review.writeOk) {
							review.writeOk = false;
						} else {
							review.writeOk = true;
							this.type = 'insert'; // 등록 버튼의 용도를 답댓글 추가로 표시 변경
						}
					} else { // 클릭한 위치가 아니면 모두 댓글쓰기영역 접기
						review.writeOk = false;
					}
				} // for
			},
	
			
			// 수정하기			
			modifyReview: function (index) {
				let review = this.reviewList[index];
	
				let obj = {
						rno: review.rno,
						content: this.inputModifyReview
				};
	
				// 오브젝트를 JSON 문자열로 변환
				let strJson = JSON.stringify(obj);
	
				let vm = this;
				
				$.ajax({
					url: '/review/modify',
					method: 'PUT',
					data: strJson,
					contentType: 'application/json; charset=UTF-8',
					success: function (response) {
						// 현재페이지 다시 불러오기
						vm.getList();
	
					},
					error: function () {
						alert('로그인 사용자만 댓글 수정이 가능합니다.');
						location.href = '/member/login';
					}
				});
			}
	
		},
		mounted: function () {
			this.getList();
		}
	});

</script>

</body>

</html>