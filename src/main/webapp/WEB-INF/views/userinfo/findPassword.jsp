<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findpassword</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/find.css">
    
</head>

    
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
                <a  href="logout.do">로그아웃</a>
            </div>

        </div>

    </div>
    
    <div class="find_sec" >
    
        <div class="insert_sec" >

        <div class="find_title" >
          <h2>비밀번호 찾기 </h2>           
        </div>
        <h5 style="display: inline; margin-left: 50%;">- 
            <span style="color: blue;"> 01. 아이디 입력</span> > 02. 본인 확인 &gt; 03. 비밀번호 재설정</h5>
        </div>
        <div class="total" >
            <h3 style="height: 4px; margin-right: 50%;">아이디</h3>
            <input type="text"  placeholder="아이디를 입력하세요" id="find_password" style="width: 50%;" > <br>       
        <button style="width: 30%;" type="button" onclick="location.href='findPassword2.do'">제출</button>
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