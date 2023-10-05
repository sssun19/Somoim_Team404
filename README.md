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
> 소모임 일정 테이블의 데이터를 조회해 현재 시간과 비교하여 아직 지나지 않은, 가장 가까운 일정만 홈 화면에 노출하는 로직입니다.

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

- max_member 칼럼으로 해당 모임 정원을 초과하면 가입할 수 없도록 처리하는 로직을 구현했습니다.




**myfeed 테이블**


![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/a94a7419-b49c-4de8-9b14-af860d579edb)










[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=sssun19)](https://github.com/anuraghazra/github-readme-stats)
