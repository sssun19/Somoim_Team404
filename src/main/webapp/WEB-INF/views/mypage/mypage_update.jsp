<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <script>
        $(document).ready(function() {
        	console.log('hi');
          $('.datepicker').datepicker();
        });
      </script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/mypage.css">
    <link rel="stylesheet" href="resources/css/mypage_min.css">
        <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>
<hr style="margin-bottom: 10px;">

    <div class="total_area" >
        <div class="total_position">
       <ul>
            <li>
                <div class="upper">
                    <div class="profile_area">
                        <ul>
                            <li class="profile_img_sec">
                                <img src="/Img/0112.png" alt="프로필 이미지" >
                            </li>
                            <li class = "profile_fix_but">
                                <button type="button" href="#">편집</button>
                            </li>
                        </ul>
                    </div>
                
                    <div class="insert_area">
                        <div class="mypage_id_insert_sec">
                            <!-- 아이디 -->
                            <div class="insert_area_id">
                                <h2 class="id" >아이디</h2>
                                <input type="text" placeholder="아이디를 입력하세요" id="find" value=" 이형주">
                            </div>
                            <!-- 닉네임 -->
                            <div class="insert_area_id">
                                <h2 class="id">닉네임</h2>
                                <input type="text" placeholder="닉네임를 입력하세요" id="nickname" value=" 낄낄낄">
                            </div class="insert_area_id">
                            <!-- 비밀번호 -->
                            <div class="insert_area_id">
                                <h2 class="id">비밀번호</h2>
                                <input type="password" placeholder="비밀번호를 입력하세요" id="password" value=" 이형주">
                            </div>
                            <!-- 나의 주소 -->
                            <div class="insert_area_id">
                                <h2 class="id">나의 주소</h2>
                                <input style="width: 45%;" type="text" placeholder="나의 주소를 입력하세요" id="address" value="서울특별시 성북구">
                                <button type="button" id="juso" >변경</button>

                            </div>
                            <!-- 휴대폰 번호 -->
                            <div class="insert_area_id">
                                <h2 class="id">휴대폰 번호</h2>
                                <input type="text" placeholder="아이디를 입력하세요" id="tel" value=" 01066389914">
                                <div class="insert_area_id_but" style="text-align: center; width:70%; background-color: white;"">
                                    <button class="area_id_but" type="button" id="em_certi">인증</button>
                                </div>
                            </div>
                                
                        </div>
                    </div>
                </div>
            </div>
        </ul>
        <ul>
            <li>
                <div class="email_area">
                    <div class="mypage_insert_email_footer">
                      <!-- 이메일 -->
                      <div class="email_footer_head">
                        <h2>이메일</h2>
                      </div>
                      <!-- 이메일 입력 -->
                      <div class="email_footer_body">
                        <div class="input_with_button">
                          <input type="text" placeholder="이메일을 입력하세요" id="email">
                          <button type="button" >인증 번호 전송</button>
                        </div>
                        
                        <div class="input_with_button">
                            <input type="text" placeholder="생년월일 6자리" id="find_password" class="datepicker">
                            <button type="button">인증 번호 전송</button>
                          </div>
                        <!-- 생년월일 -->
                        <div class="email_footer_head">
                            <h2>생년월일</h2>
                          </div>
                        <div class="input_with_button">
                          <input type="text" placeholder="1999.12.12" id="find_password">
                        
                        </div>
                      </div>
                    </div>
                  </div>
            </li>
        </ul>
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