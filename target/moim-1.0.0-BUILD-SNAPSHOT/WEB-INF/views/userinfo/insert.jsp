<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/style_min.css">
    <link rel="stylesheet" href="resources/css/min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#mail_check_button").click(function() {
    	console.log("mail_check_button...click");
        var input_email = $("input[name='input_email']").val();
        console.log(input_email);

        // 서버에 이메일 주소를 전송하는 Ajax 요청
        $.ajax({
            url: 'sendEmail.do',
            method: 'GET',
            data: { input_email: input_email },
            dataType:"json",
            success: function(response) {
            	console.log("response:",response);
            	console.log("response.result:",response.result);
                // 서버로부터의 응답을 처리하는 로직
                if (response.result === 'OK') {
                    alert('인증번호를 이메일로 발송했습니다.');
                } else {
                    alert('이메일 전송에 실패했습니다.');
                }
            },
           error: function() {
               alert('서버와의 통신에 실패했습니다.');
           }
        });
        return false;
    });
    
 $("#btn_email_token").click(function() {
        	console.log("btn_email_token...click");
        	var input_email = $("input[name='input_email']").val();
            console.log(input_email);
            var email_token = $("input[name='email_token']").val();
            console.log(email_token);

            // 서버에 이메일 주소와 인증 코드를 전송하는 Ajax 요청
            $.ajax({
                url: 'send_email_token.do',
                method: 'GET',
                data: {
                	input_email: input_email,
                	email_token: email_token
                },
                dataType: "json",
                success: function(response) {
                	console.log("response:", response);
                    if (response.result === 'OK') {
                        alert('인증이 완료되었습니다.');
                        // 인증 성공한 경우 추가로 수행할 로직 작성
                    } else {
                        alert('인증 코드가 일치하지 않습니다. 다시 확인해주세요.');
                    }
                },
                error: function() {
                    alert('서버와의 통신에 실패했습니다.');
                }
            });
            return false;
        });
    });

</script>
</head>

<body>
<%@ include file="../top_menu.jsp" %>

<div class="register_section">
<form action="u_insertOK.do" method="post" enctype="multipart/form-data">
    <label for="user_id">아이디</label>
    <br>
    <input type="text" placeholder="아이디를 입력하세요." name="user_id" id="user_id" value="tester">
    <br>
    <label for="user_pw">비밀번호</label>
    <br>
    <input type="password" placeholder="비밀번호를 입력하세요." name="pw" id="user_pw" value="hi111">
    <br>
    <label for="user_pw">비밀번호 확인</label>
    <br>
    <input type="password" placeholder="비밀번호를 입력하세요." name="pw_check" id="pw_check" value="hi111">
    <br>
    <label for="user_name">이름</label>
    <br>
    <input type="text" placeholder="이름를 입력하세요." id="name" name="name" value="kim12">
    <br>
    <div class="birth_gender">
        <span>
            <label>생년월일</label>
            <br>
            <select name="birthday_year">
                <option value="2000">2000</option>
                <option value="2001">2001</option>
                <option value="2002">2002</option>
            </select>

            <select name="birthday_month">
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
            </select>

            <select name="birthday_day">
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
            </select>
        </span>

        <span>
            <label>성별</label>
            <br>
            <select>
                <option>남자</option>
                <option>여자</option>
            </select>
        </span>
    </div>
    <label for="user_profile">프로필 사진</label>
    <br>
    <input type="file" name="file" id="file" value="">
    <br>
    <label for="user_email">이메일</label>
    <br>
    <div class="register_input_flex">
        <input type="email" placeholder="이메일을 입력하세요" name="input_email" class="mail_check_input">
        <button type="button" class="mail_check_button" id="mail_check_button">인증번호</button>
    </div>
    <br>
    <div class="register_input_flex">
        <input type="text" placeholder="인증번호 입력" name="email_token" id="email_token" value="">
        <button id="btn_email_token">확인</button>
    </div>
    <br>
    <input id="register" type="submit" value="회원가입">   

        </form>

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