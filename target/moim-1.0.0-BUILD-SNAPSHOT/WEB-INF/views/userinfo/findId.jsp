<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
    <script>
        function showMessage() {
         var alertMessage = "[알림] 네이버가 발송한 메일이 스팸 메일로 분류된 것은 아닌지 확인해 주세요. 스팸 메일함에도 메일이 없다면, 다시 한 번 '인증번호 받기'를 눌러주세요.";
        alert(alertMessage);
        }
    </script>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>findID</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/find.css">
</head>
    
    
<body>
        <div class="header">
        <div class="gnb">
            <div class="logo">
                <img src="resouces/uploadimg/logo.png">
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

    <div class="find_sec" >
    
        <div class="insert_sec" >

        <div class="find_title" >
          <h2>아이디 찾기 </h2>           
        </div>


            <div class="total" >
                <div class="insert_id">
                    <h3 style="height: 4px; margin-right: 50%;">이름</h3>
                    <input type="text"  placeholder="이름을 입력하세요" id="find_password" style="width: 50%;" > <br>       
                </div>   
                    <div class="email" >
                        <div class="emailtitle" >
                            <h3  style="height: 4px; ">이메일</h3>
                            <h5 >본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h5>
                        </div>
                        <div class="inser_email">
                            <input type="text" placeholder="이메일을 입력하세요" id="find_password">     
                            <button type="button" >인증 번호 전송</button>
                        </div>
                    </div>    
                
                    <div class="insert_certi" >  
                            <input type="text" placeholder="인증 번호 6자리를 입력해주세요"  id="find_password">                 
                            <br>
                            <div class="injarea" style="text-align: center;">
                            <button id="inj" type="button" onclick="showMessage()">인증번호가 오지 않았나요?</button> <br>
                            </div>
                        <button type="button" id="submitpass" onclick="location.href='findPassword.do'">비밀번호 찾기</button>
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