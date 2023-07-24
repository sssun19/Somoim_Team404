<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
      <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript">
  function check(){
	  if(loginform.user_id.value.length == 0){
		  alert("아이디가 누락되었습니다.");
		  loginform.user_id.focus();
		  return false;
	  }
	  if(loginform.pw.value.length == 0){
		  alert("비밀번호가 누락되었습니다.");
		  loginform.pw.focus();
		  return false;
	  }
  }
    </script>

    <script>
        $(document).ready(function () {
            $("#checkButton").click(function () {
                var username = $("#user_id").val();

                // Ajax 호출
                $.ajax({
                    url: 'json_m_idCheck.do',
                    method: 'GET',
                    data: { user_id: username },
                    dataType: 'json',
                    success: function (response) {
                        console.log(response);

                        // 서버에서 반환된 JSON 데이터의 result 값을 확인하여 메시지 출력
                        if (response.result === 'OK') {
                            $("#resultMessage").text('생성 가능한 아이디입니다.');
                        } else if (response.result === 'NotOK') {
                            $("#resultMessage").text('이미 생성된 아이디가 있습니다.');
                        } else {
                            $("#resultMessage").text('오류가 발생하였습니다.');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log('xhr.status : ', xhr.status);
                        $("#resultMessage").text('오류가 발생하였습니다.');
                    }
                });
            });
        });
    </script>
</head>
<body>
   <jsp:include page="../top_menu.jsp"></jsp:include>

    <div class="login_section">



       <form action="loginOK.do" method="post" name="loginform" onsubmit="return check();">

            <label for="user_id">아이디</label>
            <br>
            <input type="text" placeholder="아이디를 입력하세요." id="user_id" name="user_id" placeholder="아이디를 입력해주세요">


           <br>

            <label for="user_pw">비밀번호</label>
            <br>
            <input type="password" placeholder="비밀번호를 입력하세요." id="user_pw" name="pw" placeholder="비밀번호를 입력해주세요.">
            <br>
            <div class="sub_login">
      
                <span>
                <a href="u_findId.do">아이디/비밀번호 찾기</a>
                <a href="u_insert.do">회원가입</a>
                </span>
            </div>

            <input id="login_btn" type="submit" value="로그인"></input>
        </form>
        	<p>${message}</p>
    </div>


<br>

    <div class="footer">
        <div>
            <strong>온앤오프</strong>
            <ul>
                <li>공지사항</li>
                <li>이벤트</li>
                <li>자주 믿는 질문</li>
            </ul>
        </div>
        <div>
            <strong>소셜 미디어</strong>
            <ul>
                <li>인스타그램</li>
                <li>네이버 블로그</li>

            </ul>
        </div>
        <div class="footer_company">
            <strong>온앤오프</strong>
            <ul>
                <li>대표: 팀404 개인정보관리책임자: 팀404</li>
                <li>이메일: Team404@Team404.com 대표번호: 123-1234-1234</li>
                <li>주소: 서울시 강남구 태헤란로 ~~~~~</li>
            </ul>
        </div>

    </div>
</body>
</html>