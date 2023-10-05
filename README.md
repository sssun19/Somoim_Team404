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
- category 를 구분해 소모임 전체 조회 페이지에서 카테고리별 검색이 가능하도록 구현했습니다.<br/>
 해당 로직은 jsp 파일에서 AJAX 비동기 통신을 이용했습니다.

```
$(function() {
   $("input[name='category']").on('click', function() {
      console.log("onload...");
      var category = $(this).val();
      console.log($(this).val());
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
            $('.paging').hide();
         },
         error : function(xhr, status, error){
            console.log('xhr.status : ', xhr.status);
         }
      });//end ajax
});//end click

```

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



**somoim_member 테이블**


![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/a0234e88-ca70-4414-a2cc-26d6098689e3)

> max_member 칼럼으로 해당 모임 정원을 초과하면 가입할 수 없도록 처리하는 로직을 구현했습니다.


**myfeed 테이블**


![image](https://github.com/sssun19/Somoim_Team404/assets/125242481/a94a7419-b49c-4de8-9b14-af860d579edb)










[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=sssun19)](https://github.com/anuraghazra/github-readme-stats)
