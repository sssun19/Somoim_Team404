# 소모임 웹 서비스 개발

멀티캠퍼스 파이널 프로젝트

<h3>개발기간 : 2023.06.09 ~ 2023.07.28 (설계 및 테스트 포함)</h3>
최적화 중(WebSocket 연동)

## info


### 테스트용 계정
> 아이디 : tester <br/>
> 비밀번호 : hi111

### DB Oracle 정보
> sqlDeveloper 유저 생성 <br/>
> User명 : ONANDOFF <br/>
> 비밀번호 : hi123456 <br/>
> onandoff.sql 다운로드 후 전체 query 실행

### 기술 스택
- Framework: **Spring Framework**
- Language: **Java, Javascript**
- Database: **Oracle, mongoDB**
- DB Access Skill : **MyBatis**
- 기타 : **AWS**
- 소스관리 : **Git, Github**

### 맡은 파트
- DB
1. 전체 DB 테이블 설계
2. MyBatis sqlMapper 설계
3. AWS RDS 연동

   
- 프로그래밍
1. somoim_member (소모임 가입, 탈퇴)
2. somoim (소모임 생성, 소모임 삭제, 소모임 전체보기, 카테고리 선택, 키워드 검색)
3. mypage (마이페이지 조회, 개인정보 수정, 가입한 소모임 조회, 내가 생성한 소모임 조회)
4. mypage_# (내가 누른 좋아요, 내가 단 댓글, 내가 쓴 게시글 조회)
5. myfeed (자기소개 수정)


# WebSocket 연동
### 최적화

- pom.xml

```
<!-- WebSocket -->
<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-websocket</artifactId>
		<version>4.2.4.RELEASE</version>
</dependency>
<dependency>
		<groupId>javax.websocket</groupId>
		<artifactId>javax.websocket-api</artifactId>
		<version>1.1</version>
</dependency>
```


- servlet-context.xml


```
<!-- websocket handler -->
<beans:bean id="replyEchoHandler" class="test.com.moim.socket.ReplyEchoHandler">

<websocket:handlers>
	<websocket:mapping path="/replyEcho" handler="replyEchoHandler"/>
	<websocket:handshake-interceptors>
		<beans:bean
				class="org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor"></beans:bean>
	</websocket:handshake-interceptors>
</websocket:handlers>

</beans:bean>
```

- ReplyEchoHandler 클래스

```

public class ReplyEchoHandler extends TextWebSocketHandler {

	List<WebSocketSession> sessions = new ArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception { //connection 이 연결 됐을 때
		System.out.println("afterConnectionEstablished:" + session);
		sessions.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { //socket에 message를 보냈을 때
		System.out.println("handleTextMessage: " + session + " : " + message);
		String senderId = session.getId();
		for (WebSocketSession sess: sessions) {
			sess.sendMessage(new TextMessage(senderId+ ": "+ message.getPayload()));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { //connection close 됐을 때
		System.out.println("afterConnectionClosed: " + session + ": " + status);
	}
}
```


> 이미지 전송이 아닌 단순 텍스트 전송이기 때문에 TextWebSocketHandler 클래스 상속 (이미지 전송을 원하면 BinaryWebSocketHandler 상속)<br/>
> session 에 저장된 (접속한 모든 이용자의 세션) 정보들을 List 형태로 관리<br/>
> session에 저장된 유저의 아이디를 가져와 senderId 에 할당. foreach 구문으로 모든 이용자에게 메세지 전송

<br/>

- board 게시글.jsp

```
<script>
function connect() {
	const ws = new WebSocket("ws://localhost:8089/replyEcho?num=121");
	console.log('connect success...');

	ws.onopen = function() {
			console.log('Info: connection opened.');
	};

	ws.onmessage = function (event) {
			console.log(event.data+'\n');
	};

	ws.onclose = function (event) { 
			console.log('Info: connection closed.', event);
			setTimeout( function(){ connect(); }, 1000); // 통신이 종료되면 1초마다 한번씩 재시도
	};
	
	ws.onerror = function(err) { console.log('Error:', err); };
	
}

</script>

<script>
	$(document).ready( function(){
			$('#btnSend').on('click', function(evt) {
					evt.preventDefault();
	
					if (socket.readyState !== 1) return;
					let msg = $('input#msg').val();
					socket.send(msg);
			});
	
			connect();
	});
</script>

```

<br/>

💁 WebSocket 과 Socket 의 차이점

- Socket 통신 구현

```
@ServerEndpoint("/replyEcho")
public class ReplyHandler {

	@OnOpen
	public void onOpen(Session session){
			System.out.println("websocket open...inclass : "+ session);
	}

	@OnMessage
	public String onMessage(String message, Session session) throws IOException {
			System.out.println("websocket onMessage... : "+ session);
			String senderId = session.getId();

			return senderId+":"+message;
	}

	@OnClose
	public void onClose(Session session) {
			System.out.println("afterConnectionClosed:" + session + " : ");
	}
}
```

<br/>

> @ServerEndpoint annotation 으로 socket path 를 지정하여 handler 클래스와 매핑해준다<br/>
> onOpen, onMessage 메서드(annotation)를 이용해 socket 이 열리거나 메세지 통신을 했을 때의 로직을 구현한다<br/>
> **WebSocket 관련 메서드는 사용하지 않을 것**<br/>
> 위 Socket 통신 구현은 일방적인 통신만 가능하도록 구현되어 있다.

<br/>

- WebSocket 통신은 웹 상에서 실시간 양방향 통신이 가능해서 btnSend 버튼을 눌러 메세지를 전송하면 모든 서버의 콘솔에 로그가 찍힌다.<br/>
- 웹에서 웹소켓을 지원하기 때문에 웹 서버 개발에서 양방향 통신을 개발할 때는 WebSocket 을 사용하는 것이 바람직하다.<br/>
- Socket 으로도 양방향 통신이 가능하지만 서버와 클라이언트 측 로직을 모두 구현해야 하므로 까다롭다.


💁 WebSocket 실시간 양방향 통신으로 댓글 작성 알림 기능 구현 순서

1. WebSocket 전역 연결(모든 페이지에서 websocket 알림을 받을 수 있도록 하기 위함)
2. Server 에서는 로그인 사용자의 ID 별로 SocketSession 관리가 필요함. (ID 별로 관리해야 알림을 받을 수신자에게만 따로 보낼 수 있기 때문)
3. 댓글 작성 시 WebSocket 에게 알리기
4. 알림 받는 UI 생성
5. Test 해보기
<br/>
<br/>

- 사용자의 ID 별로 session 관리 (ReplyEchoHandler.java)

유저의 아이디와 session 아이디가 필요하므로 key, value 를 가지는 Map 으로 관리한다.

```
Map<String, WebSocketSession> userSessions = new HashMap<>();

@Override
public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	...
	String senderId = getId(session);

	userSessions.put(senderId, session);
}


private String getId(WebSocketSession session) {
	Map<String, Object> httpSession = session.getAttributes();
	UserinfoVO loginUser = (UserinfoVO) httpSession.get(SessionNames.LOGIN);

	if (loginUser == null) {
		return session.getId();
	} else
			return loginUser.getUser_id();
}
```

> WebSocket session을 httpSession 변수에 할당. (웹소켓 세션은 사용자의 실제 ID가 아닌 웹 상의 session id를 가지고 있으므로 사용자의 ID 별로 세션을 관리하기 위함)<br/>
> 유저의 ID를 관리하는 UserinfoVO 클래스에서 session id를 조회.


- WebSocket 으로 알림 메세지 전송

```
<div>
<input type="text" value="test!!">
<button type="submit" onclick="sendBtn()">테스트 버튼</button>

	<script>
		function sendBtn() {
			console.log('댓글 작성 버튼 눌렀음.');
			console.log('reply.js::socket>>', socket);

			if (socket) {
				// websocket 에 전송 포맷 (reply, 댓글작성자, 게시글작성자, wnum)
				let user_id = `${user_id}`;
				let writer_id = `${vo2.user_id}`;
				let wnum = ${vo2.num};

				let socketMsg = "reply," + user_id +", "+ writer_id + ", "+ wnum;
				console.log(socketMsg);
				socket.send(socketMsg);
			} else return;
		}

	</script>
</div>
```

### DB 테이블 전체 구조
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/942359c6-0131-4f28-b43f-da84f2764f3a)


**somoim 테이블**


![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/f97be8ab-972a-4b7f-b0d9-d7b90f7cb4b6)

![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/92f787a9-faeb-42bb-9057-36f5cf5a4f13)

- som_title 칼럼에 UK 제약조건을 걸어 소모임 이름으로 중복 데이터가 들어오는 것을 방지했습니다.<br/>
- category 를 구분해 소모임 페이지에서 카테고리별 조회가 가능하도록 구현했습니다.<br/>
 해당 로직은 jsp 파일에서 AJAX 비동기 통신을 이용했습니다.


```
$(function() {
   $("input[name='category']").on('click', function() {
      console.log("onload...");
      var category = $(this).val();

      $.ajax({
         url : 'somz_selectAll.do',
         method:'GET',
         data : {
            'category':category
         },
         success : function(data){
            console.log('category', category);
            console.log('data', data);

            $('body').html(data);
         },
         error : function(xhr, status, error){
            console.log('xhr.status : ', xhr.status);
         }
      });//end ajax
});//end click

....

<c:forEach var="vo" items="${viewAll}">
	<c:if test="${vo.category eq param.category }">
		<li style="border: 1px solid lightgray; border-radius: 5%; text-align: center; display: flex; justify-content: center; align-items: center;">
			<a href="som_selectOne.do?num=${vo.num}">
				<input type="hidden" value="${vo.num}">
				<input type="hidden" value="${vo.create_date}">
				<input type="hidden" value="${vo.category}">
				<div class="moim_img" >
					<div class="img_box">
						<img src="resources/uploadimg/${vo.somoim_img}"></div>
					<span>
					<h1>${vo.som_title}</h1>
					<p class="sub_tit">소셜링 📌 ${vo.area}</p>
					<p class="sub_tit">⏱ ${vo.create_date }</p>
					</span>
				</div>
			</a>
		</li>
	</c:if>
</c:forEach>
```


> controller 에서 model.addAttribute 메서드를 통해 "viewAll" 이라는 변수로 jsp 파일에 넘겨주었습니다.<br/>
> jsp 파일에서는 해당 값을 받아와 forEach 구문으로 데이터를 조회해 파라미터로 넘어온 카테고리 값(선택한 카테고리 값)과 일치하는 카테고리의 소모임이 있다면 조회할 수 있도록 구현했습니다.<br/>
> 소모임 카테고리와 파라미터로 넘어온 카테고리를 비교하는 방법으로 jstl 을 선택했습니다.<br/>
> 프로젝트를 진행하는 기간이 길어지면서 로직이 길어졌고 jstl 문법으로 비교적 간결하고 간단하게 원하는 값을 받아올 수 있었기 때문입니다.

<br/><br/>
- som_title 칼럼을 이용해 select 조회로 키워드 검색 기능을 구현했습니다.


#### controller

```
@RequestMapping(value = "/som_searchList.do", method = RequestMethod.GET)
public String som_searchList(String searchKey, String searchWord, String category, Model model) {
   List<SomoimVO> vos = service.searchList(searchKey, searchWord, category);
   model.addAttribute("viewAll", vos);

   return "board/som_selectAll2";
}
```


#### DAOimpl
```
public List<SomoimVO> searchList(String searchKey, String searchWord, String category) {
   log.info("searchList()...{}, {}", searchKey, searchWord);
   log.info("searchList()...category : {}", category);

   Map<String, String> map = new HashMap<String, String>();
   map.put("searchWord",  "%"+searchWord+"%");
   map.put("category", category);

	if(searchKey.equals("소모임 이름")) {
		if(category=="") {
			return session.selectList("SOMOIM_SEARCH_LIST_TITLE_NONCATEGORY", "%"+searchWord+"%");
		}
		return session.selectList("SOMOIM_SEARCH_LIST_TITLE",map);
		}
		else {
			if(category=="")
				return session.selectList("SOMOIM_SEARCH_LIST_AREA_NONCATEGORY", "%"+searchWord+"%");
			return session.selectList("SOMOIM_SEARCH_LIST_AREA",map);
		}
	}
```

#### sqlMapper
```
<select id="SOMOIM_SEARCH_LIST_TITLE"
   resultType="test.com.moim.somoim.model.SomoimVO"
   parameterType="HashMap">
   select * from somoim where som_title like #{searchWord}
   and category=#{category} order by num desc
</select>

<select id="SOMOIM_SEARCH_LIST_TITLE_NONCATEGORY"
   resultType="test.com.moim.somoim.model.SomoimVO">
   select * from somoim where som_title like #{searchWord} order by num desc
</select>
```


> MyBatis 를 이용했기 때문에 sqlMapper 를 작성했습니다.<br/>
title 또는 area 값을 검색하기 때문에 Map 클래스를 이용해 동시에 두 값을 전달하였습니다.<br/>
여기서 한 가지 문제점이 발생했습니다. 카테고리를 선택한 상태에서 키워드 검색을 하면 오류가 나는 것이었습니다.<br/>
> 어떻게 해결할지 고민을 하다가 파라미터로 카테고리까지 같이 받아서 다중 if문으로 처리해 주기로 하였습니다.<br/>
카테고리를 선택하지 않고 키워드를 검색하면 sqlMapper 파일에서 #_NONCATEGORY 을 찾아가도록 구현했습니다. <br/>

<br/><br/>

- AJAX 소모임 홈 화면에서 모임 일정 disp
> 소모임 일정 테이블의 데이터를 조회해 현재 시간과 비교하여 아직 지나지 않은, 가장 가까운 일정만 홈 화면에 노출하는 로직입니다.<br/>
now 변수에 Date 클래스를 이용해 현재 시간을 할당하고 scheduleTime 변수에 data 로 받아온 소모임 일정들의 시간을 할당합니다.<br/>
SOM_SCHEDULE_SELECTONE의 SQL 문은 다음과 같습니다.

#### sqlMapper.xml

```
<select id="SOM_SCHEDULE_SELECTONE" resultType="test.com.moim.board.model.Somoim_ScheduleVO">
	select * from somoim_schedule where somoim_num=#{somoim_num}
</select>
```

#### controller

````
@ResponseBody
@RequestMapping(value = "/som_schedule_selectOne.do", method = RequestMethod.GET)
	public List<Somoim_ScheduleVO> som_schedule_SelectOne(Integer somoim_num, Model model) {
		log.info("som_schedule_SelectOne.do().....somoim_num:{}", somoim_num);
		Somoim_ScheduleVO vo = new Somoim_ScheduleVO();
		vo.setSomoim_num(somoim_num);
		
		List<Somoim_ScheduleVO> vos = service.som_schedule_selectOne(vo);
		log.info("======={}", vos);
		
		for (Somoim_ScheduleVO x : vos) {
			log.info("place : {}",x.getPlace());
			log.info(x.getSchedule_title());
		}
		
		model.addAttribute("vos", vos);
		return vos;
}
````

#### ajax 로직

```
$.ajax({
	url: 'som_schedule_selectOne.do',
	data: {
	somoim_num: ${param.num}
	},
	success: function(response) {
		console.log('ajax successsed...response:', response);
		var now = new Date();
		console.log('현재 시각:', now); // 현재 시간 체크
		var closestSchedule = null; // 가장 가까운 일정 저장할 변수 초기화
		var closestTimeDiff = Infinity;

		$.each(response, function(index, data) {
			console.log(index, data);
			
			var scheduleTime = new Date(data.schedule_date + ' ' + data.schedule_time);
			var timeDiff = scheduleTime - now;
			console.log('시간 확인:', scheduleTime);
			console.log('남은 시간:', timeDiff);

			if (timeDiff >= 0 && timeDiff < closestTimeDiff) {
			closestSchedule = data;
			closestTimeDiff = timeDiff;
			}
		});

	if (closestSchedule) {
		var schedule_selectOne = `
			<h1>일정</h1>
			<div class="cal_detail">
				<div class="detail_info">
					<h1>06/17</h1>
					<br>
					<strong>\${closestSchedule.schedule_title}</strong>
					<p>일시: \${closestSchedule.schedule_date} \${closestSchedule.schedule_time}</p>
					<p>장소: \${closestSchedule.place}</p>
					<p>회비: \${closestSchedule.money}</p>
				</div>
				<div class="detail_member">
					<!-- 참석 멤버 목록 -->
					<h1>참석 멤버</h1>
					<ul>
						<li>
							<div class="round_box">
								<i class="far fa-user"></i>
							</div>
						</li>
					</ul>
				</div>
				<div class="detail_status">
					<button type="button"><a href="join_schedule.do?somoim_num=${vo2.num}">참석</a></button>
				</div>
			</div>
		`;

		$('.join_cal').html(schedule_selectOne);
	} else {
			$('.join_cal').html('<p>가까운 일정이 없습니다.</p>');
		}
	},
	error: function(xhr, status, error) {
		console.log('xhr.status:', xhr.status);
	}
});//end ajax...
```
---

**somoim_member 테이블**


![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/a0234e88-ca70-4414-a2cc-26d6098689e3)

#### MemberVO
````
@Data
public class MemberVO {
	private int num;
	private String user_id;
	private Timestamp join_date;
	private String position;
	private String som_title;
	private String save_name;
	private int somoim_num;
}
````

- max_member 칼럼으로 해당 모임 정원을 초과하면 가입할 수 없도록 처리하는 로직을 구현했습니다.
> 해당 소모임에 가입 중인 모임원 명수를 받아옵니다. 받아온 값과 소모임 생성 당시 설정한 최대 인원 수를 비교합니다.

#### sqlMapper.xml
```
<select id="SOM_MAXMEMBER_CHECK" resultType="int">
	select count(*) from somoim_member where som_title=#{som_title}
</select>
```

#### ajax 로직
```
$("input[id='som_register']").on("click", function(){
	$.ajax({
		url:'som_maxmember_check.do',
		data: {
		som_title:'${vo2.som_title}'
		},
		success : function(response){
			console.log('response......:', response);

		if (response >= ${vo2.max_member}) {
			alert('가입 실패: 소모임 인원이 초과되었습니다.    모임 정원:${vo2.max_member} 명'); // max_member는 서버에서 설정한 최대 인원 수
		} else {
			$.ajax({
				url:'som_member_insertOK.do',
				method:'POST',
				data: {
					user_id:'${user_id}',
					num:${vo2.num},
					som_title:'${vo2.som_title}',
					save_name:'${uvo2.save_name}'
				},
				success : function(response) {
					console.log('ajax successed...');
					console.log('response : ', response);
				
					if(response==='OK') {
						alert('가입 완료되었습니다.');
						location.reload(); //가입이 완료되면 페이지를 새로고침하여 홈 페이지에 자신의 프로필 사진이 뜰 수 있도록 함.
					} else {
						alert('가입 실패: 이미 가입한 소모임입니다.');
					}
				},
				error : function(xhr, status, error){
					console.log('xhr.status : ', xhr.status);
				}
			});//end ajax
		}
	},
	error : function(xhr, status, error){
		console.log('xhr.status : ', xhr.status);
		}
	});//end ajax..
});//end click
```
> 해당 로직을 짤 때 가입도 잘 되고 프로필 사진도 뜨는데 한 가지 문제점이 있었습니다. 가입 후 사용자가 직접 새로고침을 해야만 프로필 사진을 확인할 수 있다는 것이었습니다.<br/>
엄청난 오류는 아니었지만 사용자 입장에서 무조건 새로고침을 직접 해야 한다면 굉장히 번거롭겠구나 하는 생각이 들었습니다.<br/>
아주 단순한 코드 location.reload() 한 줄 만으로 사용자의 불편을 해결할 수 있다는 것이 신기하고도 재밌게 느껴졌습니다.<br/>
이와 같이 사용자의 불편을 해결해 줄 수 있는 개발자가 되고 싶다고 생각했습니다.

---

**myfeed 테이블**

![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/a94a7419-b49c-4de8-9b14-af860d579edb)

#### myfeedVO
````
@Data
public class MyfeedVO {

	private int num;
	private String user_id;
	private String save_name;
	private int good_count;
	private int hate_count;
	private String introduce;

}
````

- 내 피드 조회하기

### controller
```
@RequestMapping(value = "/myfeed_feed_mine.do", method = RequestMethod.GET)
public String myfeed_feed_mine(Model model) {
	log.info("myfeed_feed_mine.do().....");
	String user_id = (String) session.getAttribute("user_id");
	MyfeedVO feedVo = new MyfeedVO();
	feedVo.setUser_id(user_id);

	MyfeedVO myfeedVo = myfeedService.selectOne(feedVo);


	if(myfeedVo==null) {
		log.info("null");
		int result = myfeedService.insert(user_id);
		log.info("result : {}", result);
	}

	log.info("myfeedVo....{}", myfeedVo);

	model.addAttribute("myfeedVo", myfeedVo);
	return "myfeed/myfeed_feed_mine";
}
```

### sqlMapper.xml
```
<select id="MYFEED_SELECTONE"
		resultType="test.com.moim.myfeed.model.MyfeedVO">
	select * from myfeed where user_id=#{user_id}
</select>

<insert id="MYFEED_INSERT"
		parameterType="test.com.moim.myfeed.model.MyfeedVO">
	insert into myfeed (num, user_id) values (seq_myfeed.nextval, #{user_id})
</insert>
```

> Myfeed 테이블이 존재하지 않는 사용자를 만나면 MYFEED_INSERT 매퍼로 insert query를 실행합니다.

- introduce 칼럼으로 나를 소개할 수 있는 피드를 구현해 보았습니다.

#### sqlMapper.xml

#### 버튼 클릭 시 javascript
````
function myfeed_update() {
	console.log('눌렀다!');

	// li 태그 가져오기
	let liElement = document.getElementById("letmeintroduce");
	// input 태그 생성
	let inputElement = document.createElement("input");

	inputElement.type = "text";
	inputElement.value = liElement.innerText;
	inputElement.id = "introduce";

	// li <-> input
	liElement.parentNode.replaceChild(inputElement, liElement);

	$("#updatebutton").show();
}
````
> 버튼을 누르면 input 태그를 생성하고 기존의 li 태그와 교체하는 작업입니다.<br/>
아직 웹 페이지 상 생성되지 않은 input 태그를 li 태그와 교체해 수정한 자기소개 텍스트 데이터가 화면상으로 노출됩니다.<br/>

#### ajax 로직
````
function myfeed_updateOK() {
	console.log('눌렸다');

	let updatedIntroduce = $('#introduce').val();

	$.ajax({
			url: 'myfeed_feedupdate.do',
			data: {
					user_id: '${param.user_id}',
					introduce: updatedIntroduce
			},
			success: function(response) {
					console.log('ajax successed...:', response);
					$('#letmeintroduce').text(updatedIntroduce);
					location.reload();
			},
			error: function(xhr, status, error) {
					console.log('xhr.status : ', xhr.status);
			}
	});
}
````
> 이 부분에서 많이 애를 먹었습니다. input 태그를 만들어서 자기소개 데이터를 전송했는데 수정 완료 버튼을 눌러도 화면에는 아무런 텍스트도 뜨지 않았습니다.<br/>
아무 데이터도 담기지 않은 li 태그가 계속해서 보였던 것입니다. 이 사안을 어떻게 해결해야 할지 굉장히 많이 고민했고 여러 시도를 거쳤습니다.<br/>
로그를 군데군데 찍어 서버에서 입력한 텍스트 값을 받아오기는 하는지, DB 상으로 수정은 됐는지 등을 확인하고도 문제가 해결이 되지 않아 결국 강사님께 도움을 청했습니다. <br/>
답은 parentNode.replaceChild() 에 있었습니다. 부모 노드에서 li 태그를 찾아 새로 만든 input 태그와 수정해야 한다는 사실을 깨달았습니다. 검색이나 강사님의 도움이 없었다면 혼자서 해결할 수 없는 문제였던 것 같습니다. 이 계기로 데이터 구조나 node 에 관해 많은 관심이 생겼습니다.


### 기타 로직
1. jquery로 파라미터 아이디와 로그인 아이디 조회하기

내 피드로 들어갔을 경우
<br/>
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/6a791224-f481-4683-b025-ecffdc79a129)
<br/>
다른 유저의 피드로 들어갔을 경우
<br/>
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/cdaa0432-4c1e-46bb-9852-ab188c35e33d)

```
<script type="text/javascript">
	if('${param.user_id}'==='${vo2.user_id}') {
			console.log('내가 피드 주인!');
			$('#feed_mine').show();
			$('#feed_notmine').hide();
	} else {
			console.log('나는 구경꾼!');
			$('#feed_notmine').show();
			$('#feed_mine').hide();
	}
</script>
```

2. 마이페이지 나의 활동 조회
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/9d063481-0535-4a5f-8ba4-18d2e0b3b803)
<br/>

#### Restcontroller
```
@ResponseBody
@RequestMapping(value = "/Rest_Mypage_myactivity_boardbyme.do", method = RequestMethod.GET)
public List<Somoim_BoardVO> Rest_Mypage_myactivity_boardbyme(HttpServletRequest request) {
	log.info("Mypage_myactivity_boardbyme.do....{}");
	String user_id= request.getParameter("user_id");
	Somoim_BoardVO vo = new Somoim_BoardVO();
	vo.setUser_id(user_id);
	
	List<Somoim_BoardVO> vos = service.mypageMyactivity_boardbyme(vo);
		
	return vos;
}
```

#### sqlMapper.xml
````
<select id="MYPAGE_BOARDBYME"
	resultType="test.com.moim.board.model.Somoim_BoardVO">
	select * from somoim_board a join somoim_member b on a.som_member_num=b.num 
	join somoim c on a.somoim_num=c.num where user_id=#{user_id}
</select>
````

> somoim_board 테이블과 somoim_member 테이블을 select join 문으로 동시에 조회<br/>
user_id 칼럼으로 해당 사용자가 작성한 모든 소모임의 게시글을 조회할 수 있었습니다.


#### ajax 로직
```
$(function(){
	console.log('onload........');
	
	$.ajax({
		url:'Rest_Mypage_myactivity_boardbyme.do',
		data: {
				user_id:'${param.user_id}'
			},
		success: function(vos){
			console.log('response.......:{}', vos);
			
			let tag_vos = '';
			
			$.each(vos, function(index, vo){
				console.log(index, vo);

				// Unix timestamp를 Date 객체로 변환
					const date = new Date(vo.write_date);

					// 날짜를 한국 시간대로 변환하여 "yyyy.MM.dd" 형식으로 표시
					const formattedDate = date.toLocaleString("ko-KR", {
						timeZone: "Asia/Seoul",
						year: "numeric",
						month: "2-digit",
						day: "2-digit",
					});

				tag_vos += `
				 //생략
				`;
				
			});
			$('#selectComm').html(tag_vos);
		},
		error : function(xhr, status, error){
			console.log('xhr.status : ', xhr.status);
		}
	});
});
```

3. 소모임 조회

가입한 모든 소모임 조회<br/><br/>
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/366effc3-dc12-4cf7-9e19-ca58ff3cae87)
<br/><br/>

내가 만든 소모임 보기 버튼 클릭 시
<br/><br/>
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/691dcfc3-9663-46e7-a702-496ec6b1552f)


#### controller
```
@ResponseBody
@RequestMapping(value = "/somoimbyme_selectAll.do", method = RequestMethod.GET)
	public List<SomoimVO> somoimbyme_selectAll(String user_id){
		log.info("user_id : {}", user_id);

		List<SomoimVO> vos = service.somoimbyme_selectAll(user_id);
		return vos;
}
```

#### sqlMapper.xml
```
<select id="SOMOIMBYME_SELECT_ALL"
	resultType="test.com.moim.somoim.model.SomoimVO">
	select * from somoim where somoim_master = #{user_id}
</select>
```

#### ajax 로직
```
function somoimbyme_selectAll(){
	$.ajax({
		url : 'somoimbyme_selectAll.do',
		data : {
			user_id : '${user_id}'
		},
		success : function(vos) {
			console.log('ajax successed... somoimbyme : ', vos);
			
			let tag_vos = '';

			$.each(vos,function(index,vo){
				console.log(index,vo);
				console.log('somoim_img : ', vo.somoim_img);
				
				tag_vos += `
						//생략
					`;
			});

			$('#img_somoim').html(tag_vos);	
		},
		error : function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}
```



---
## 마무리

### 결과
![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/e86e5ec4-8b62-41c9-9eab-c776bdea7543)


### 느낀점
  개발 언어는 수없이 많고 공부를 하고 있는 이 순간에도 코딩 트렌드는 계속해서 변화하고 있음을 깨달았습니다. 수많은 라이브러리와 내장 함수들을 단기간에 단순 암기하는 방식으로는 제가 바라는 목표에 도달할 수 없다고 생각했습니다.

  그래서 저는 훌륭한 멘토님들과 주강사, 보조강사님께 질문하는 것을 멈추지 않았습니다. 또한 구글링, 공식 홈페이지, stack overflow 등 검색 기능을 활용했습니다. 코드의 오류 중 절반 이상은 공식 홈페이지에서 사용 방법을 잘 살펴 보면 해결이 되는 내용들이었습니다. 그런데도 고쳐지지 않는 오류는 stack overflow 나 구글링을 통해 다른 선배 개발자들의 개발 블로그 게시글을 보고 고칠 수 있었습니다.

  저는 배운 것을 가공하여 여러 시도를 해봤습니다. 혼자서 짠 코드에서 오류가 나지 않으면 스스로 성장했음을 알 수 있었고 그렇게 개발자라는 직업에 매력을 느꼈습니다. 이번 프로젝트를 계기로 코딩이 얼마나 재밌는지, 그리고 이 모든 과정을 함께해 준 팀원들의 존재가 얼마나 소중한지를 깨달을 수 있었습니다. 아주 진귀하고 값진 시간이었습니다.



[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=sssun19)](https://github.com/anuraghazra/github-readme-stats)
