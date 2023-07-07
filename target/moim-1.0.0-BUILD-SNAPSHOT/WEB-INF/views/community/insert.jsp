<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/community.css">
<script src="https://kit.fontawesome.com/1652357a48.js"
	crossorigin="anonymous"></script>
<title>Document</title>



</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>

	<form action="community_insertOK.do" method="post"
		enctype="multipart/form-data">
		<div class="community_section">
			<div class="c_insert_func">
				<label for="image-upload" class="toolbar-label"> <i
					class="fas fa-image"></i><a>이미지</a>
				</label> <input type="file" id="image-upload" name="image-upload"
					class="file-input" accept="image/*"> <label
					for="file-upload" class="toolbar-label"> <i
					class="fas fa-file-alt"></i><a>파일</a>
				</label> <input type="file" id="file-upload" name="file-upload"
					class="file-input" accept="*"> <label for="text-size"
					class="toolbar-label"> <i class="fas fa-text-height"></i>
				</label> <select id="text-size" class="toolbar-select">
					<option value="small">작게</option>
					<option value="medium">보통</option>
					<option value="large">크게</option>
				</select> <label for="text-style" class="toolbar-label"> <i
					class="fas fa-font"></i>
				</label> <select id="text-style" class="toolbar-select">
					<option value="normal">보통</option>
					<option value="italic">이탤릭</option>
					<option value="bold">굵게</option>
				</select>
			</div>
			<div class="community_insert_section">
				<div class="writer">
					<h3>
						<label for="writer">작성자</label>
					</h3>
				</div>
				<div>
					${user_id} <input type="hidden" id="user_id" name="user_id"
						value="${user_id}">
				</div>
				<div>
					<h2>
						<label for="title">제목</label>
					</h2>
				</div>
				<div>
					<input type="text" id="title" name="title" value="테스트제목">
				</div>
				<div>
					<h3>
						<label for="content">내용</label>
					</h3>
				</div>
				<div>
					<textarea id="insert_content" name="content"
						placeholder="내용을 입력해주세요"></textarea>
				</div>
				<div class="center">
					<input type="submit" value="작성완료">
				</div>
			</div>
		</div>
	</form>
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