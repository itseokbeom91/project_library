<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
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

div#chatbox {
	width: 900px;
	height: 500px;
	padding: 25px 15px;
	border: 1px solid black;
	background-color: #ededed;
	overflow: auto;
}

div#chatbox span.me {
	background-color: #68aff7;
	border-radius: 10px;
	padding: 10px;
}
div#chatbox span.others {
	background-color: white;
	border-radius: 10px;
	padding: 10px;
}

div#chatbox div {
	margin-bottom: 25px;
}

div#chatbox div.me {
	text-align: right;
}
div#chatbox div.others {
	text-align: left;
}
</style>
<title>Insert title here</title>
</head>
<body>

<%-- header 영역 --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%-- sidebar 영역 --%>
<jsp:include page="/WEB-INF/views/include/sideBar.jsp" /> 

<div id="wrap">
	<article id="app">
		<h3><div style= "border:1px solid lightgray; padding: 15px; margin-bottom: 32px;">
				<span style="font-weight:bold;">${ room.title }</span>
			</div>
		</h3>
		<div id="bookContent_sy" style="margin-bottom: 40px; text-align: center;">
			<div id="notice">
				<div id="chatbox" v-html="chatboxContent"></div>
				<input type="hidden" v-model="nickname">
<!-- 				<input type="text" v-model="message" v-on:focus.once="enter" v-on:keyup.enter="send" placeholder="채팅글을 입력하세요" > -->
			</div>
			<br>
			<div style="display: flex; margin-left: 100px;">
				<textarea style="resize: none; margin-right: 10px" rows="5" cols="100" v-model="message" v-on:focus.once="enter" v-on:keyup.enter="send" name="content" placeholder="채팅글을 입력하세요."  border= "solid 1px #ebebeb" background-color="#f8f8f8"></textarea>
				<div style="display: block;">
					<input type="button" value="전송" v-on:click="send" style="display: block;">
					<input type="button" value="채팅방 연결끊기" v-on:click="disconnect" style="display: block;">
				</div>
			</div>
		</div>
    </article>
</div>



<%-- footer 영역 --%>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
<script>
	const roomId = '${ room.roomId }';
	var mySessionId;
	var webSocket;

	var app = new Vue({
		el: '#app',
		data: {
			nickname: '${ id }',
// 			nickname: '', // 닉네임 사용 시
			message: '',
			chatboxContent: '',
			showNickname: true,
			showChatting: false
		},
		methods: {
			enter: function () {
				this.connect();
				this.addWinEvt();
			},
			connect: function () {
				webSocket = new WebSocket('ws://localhost:8088/chat');
				webSocket.onopen = this.onOpen;
				webSocket.onmessage = this.onMessage; // 소켓서버로부터 데이터를 받을때 호출됨
				webSocket.onclose = this.onClose;
			},
			onOpen: function () {
				this.showNickname = false;
				this.showChatting = true;
				
				let obj = {
						type: 'ENTER',
						roomId: roomId,
						writer: this.nickname
				};
				let str = JSON.stringify(obj);
				webSocket.send(str);
			},
			onMessage: function (event) {
				let data = event.data; // json 문자열을 받음
				let obj = JSON.parse(data);
				let str = '';
				
				if (obj.type == 'SESSION_ID') {
					mySessionId = obj.sessionId;
				} else if (obj.type == 'ENTER') {
					str = `<div>
					           <span>\${obj.writer}님이 입장하셨습니다.</span>
						   </div>`;
				} else if (obj.type == 'LEAVE') {
					str = `<div>
					           <span>\${obj.writer}님이 퇴장하셨습니다.</span>
					       </div>`;
				} else { // obj.type == 'CHAT'
					if (obj.sessionId == mySessionId) {
						str = '<div class="me"><span class="me">';
					} else {
						str = '<div class="others"><span class="others">';
					}
					str += `\${obj.writer} : \${obj.message}</span></div>`;
				}
				this.chatboxContent += str;
				this.scrollDown();
			},
			onClose: function () {
				this.chatboxContent += '<div>채팅방 연결을 끊었습니다.</div>';
				this.scrollDown();
			},
			disconnect: function () {
				let obj = {
						type: 'LEAVE',
						roomId: roomId,
						writer: this.nickname
				};
				let str = JSON.stringify(obj);
				webSocket.send(str);
				webSocket.close();
			},
			send: function () {
				if (this.message == '') {
					return;
				}

				let obj = {
						type: 'CHAT',
						//sendWho: 'ME',
						roomId: roomId,
						sessionId: mySessionId,
						writer: this.nickname,
						message: this.message
				};
				let str = JSON.stringify(obj);
				webSocket.send(str);
				this.message = '';
			},
			scrollDown: function () {
				let chatbox = document.getElementById('chatbox');
				chatbox.scrollTop = chatbox.scrollHeight;
			},
			addWinEvt: function() {
				window.addEventListener('beforeunload', function (event) {
					let dialogText = 'Dialog text here';
					// Chrome requires returnValue to be set
					event.returnValue = dialogText;
					return dialogText;
				});

				let vm = this;
				window.addEventListener('unload', function () {
					vm.disconnect();
				});
			}
		}
	});
</script>
</body>
</html>