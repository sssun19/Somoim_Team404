<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findID2</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/find.css">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
    function findId2() {
        var name = $("#name").val();
        var email = $("input[name='email']").val();

        $.ajax({
            url: 'findId2.do',
            method: 'POST',
            data: {
                name: name,
                email: email
            },
            success: function(response) {
                $("#result").text(response);
            },
            error: function() {
                alert('아이디 검색에 실패했습니다.');
            }
        });
    }
</script>
<body>
    <div class="header">
        <div class="gnb">
            <div class="logo">
                <img src="resources/uploadimg/logo.png">
            </div>
            <nav>
                <ul>
                    <li><a>원데이</a></li>
                    <li><a>소모임</a></li>
                    <li><a>이벤트</a></li>
                    <li><a>커뮤니티</a></li>
                    <li><a>고객센터</a></li>
                </ul>
            </nav>
            <div class="main_search">
                <input type="search" placeholder="검색">
            </div>
            <div class="login">
                <a href="login.do">로그인</a>
                <a href="logout.do">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="find_sec">
        <div class="insert_sec">
            <div class="find_title">
                <h2>아이디 찾기</h2>
            </div>
            <div class="total">
                <div class="result">
                    <h3>회원님의 아이디는 다음과 같습니다:</h3>
                    <h4 id="result"></h4>
				</div>
            </div>
        </div>
    </div>

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
