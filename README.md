# 소모임 웹 서비스 개발


멀티캠퍼스 파이널 프로젝트

## info


### 테스트용 계정
> 아이디 : tester <br/>
> 비밀번호 : hi111

### DB 유저 정보
> oracle.USER=ONANDOFF <br/>
> oracle.PASSWORD=hi123456

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
4. mypage_... (내가 누른 좋아요, 내가 단 댓글, 내가 쓴 게시글 조회)
5. myfeed (자기소개 수정)



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
> jsp 파일에서는 해당 값을 받아와 forEach 구문으로 데이터를 조회해 파라미터로 넘어온 카테고리 값(선택한 카테고리 값)과 일치하는 카테고리의 소모임이 있다면 조회할 수 있도록 구현했습니다.

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
카테고리를 선택하지 않고 키워드를 검색하면 sqlMapper 파일에서 #_NONCATEGORY 을 찾아가도록 구현했습니다. <br/>

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
> 해당 소모임에 가입 중인 전체 모임원의 수를 값을 받아옵니다. 받아온 값과 소모임 생성 당시 설정한 최대 인원 수를 비교합니다.

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





[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=sssun19)](https://github.com/anuraghazra/github-readme-stats)
