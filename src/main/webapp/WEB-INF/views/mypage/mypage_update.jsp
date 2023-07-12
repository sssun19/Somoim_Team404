<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<script>
	$(document).ready(function() {
		$('.datepicker').datepicker();
	});
</script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="resources/css/min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/mypage_update_min.css">
<link rel="stylesheet" href="resources/css/Mypage_update.css">
</head>
<body>


	<hr style="margin-bottom: 10px;">
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="total_area">
		<div class="total_position">
			<ul>
				<li>
					<div class="upper">
						<div class="profile_area">
							<ul>
								<li class="profile_img_sec"><img
									src="resources/uploadimg/아이유.png" alt="프로필 이미지"></li>
								<li class="profile_fix_but">
									<button type="button" href="#">편집</button>
								</li>
							</ul>
						</div>

						<div class="insert_area">
							<div class="mypage_id_insert_sec">
								<!-- 아이디 -->
								<div class="insert_area_id">
									<h2 class="mem_info">이름</h2>
									<input type="text" placeholder="아이디를 입력하세요" id="find"
										value=" 이형주">
								</div>
								<!-- 닉네임 -->
								<div class="insert_area_id">
									<h2 class="mem_info">닉네임</h2>
									<input type="text" placeholder="닉네임를 입력하세요" id="nickname"
										value=" 낄낄낄">
								</div class="insert_area_id">
								<!-- 비밀번호 -->
								<div class="insert_area_id">
									<h2 class="mem_info">비밀번호</h2>
									<input type="password" placeholder="비밀번호를 입력하세요" id="password"
										value=" 이형주">
								</div>
								<!-- 나의 주소 -->
								<div class="insert_area_id">
									<h2 class="mem_info">나의 주소</h2>
									<input style="width: 32%;" type="text"
										placeholder="나의 주소를 입력하세요" id="address" value="서울특별시 성북구">
									<button type="button" id="juso">변경</button>

								</div>
								<!-- 휴대폰 번호 -->
								<div class="insert_area_id">
									<h2 class="mem_info">휴대폰 번호</h2>
									<div class="insert_area_Tel">
										<input type="text" placeholder="아이디를 입력하세요" id="tel"
											value=" 01066389914">

									</div>

								</div>

							</div>
						</div>
					</div>
		</div>
		</li>
		<li>
			<form action="#">
				<!-- 각 항목별로 css 설정되어 있으므로, 필요한 위치에 form 태그 작성해도 무방-->
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
								<button type="button">인증 번호 전송</button>
							</div>
							<p style="font-size: 1px;">인증번호 입력 필요</p>
							<!-- 인증번호 입력 -->
							<div class="input_with_button">
								<input type="text" placeholder="인증번호" id="number_autho_"
									class="datepicker">
								<button type="button">인증 번호 전송</button>
							</div>
						</div>


						<!-- 생년월일 -->
						<div class="birth_part">
							<div class="email_footer_head">
								<h2>생년월일</h2>
							</div>
							<div class="input_with_button">
								<input type="text" placeholder="1999.12.12" id="birth">

							</div>
						</div>
					</div>
				</div>
			</form>
		</li>
		</ul>
		<button type="submit">수정하기</button>
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