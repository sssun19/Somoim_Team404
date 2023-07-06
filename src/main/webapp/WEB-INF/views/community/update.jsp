<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/community.css">

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet" />
<!-- <script src="https://kit.fontawesome.com/1652357a48.js" -->
<!-- 	crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script> -->
	<script>
  // 페이지가 로드되었을 때 실행될 함수
  window.addEventListener('DOMContentLoaded', function () {
    // CKEditor를 초기화합니다.
    CKEDITOR.replace('insert_content');
  });
</script>
<title>Document</title>

</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>

	<form action="community_updateOK.do" method="post"
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
				<div class="num">
					<label for="num">${vo2.num}</label> <input type="hidden" id="num"
						name="num" value="${vo2.num}">
				</div>
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
					<input type="text" id="title" name="title" value="${vo2.title}">
				</div>
				<div>
					<h3>
						<label for="content">내용</label>
					</h3>
				</div>
				<!-- 				<div class="editor-menu"> -->
				<!-- 					<button id="btn-bold"> -->
				<!-- 						<b>B</b> -->
				<!-- 					</button> -->
				<!-- 					<button id="btn-italic"> -->
				<!-- 						<i>I</i> -->
				<!-- 					</button> -->
				<!-- 					<button id="btn-underline"> -->
				<!-- 						<u>U</u> -->
				<!-- 					</button> -->
				<!-- 					<button id="btn-strike"> -->
				<!-- 						<s>S</s> -->
				<!-- 					</button> -->
				<!-- 					<button id="btn-image">IMG</button> -->
				<!-- 					<select id="select-font-size"> -->
				<!-- 						<option value="">폰트 사이즈</option> -->
				<!-- 						<option value="1">10px</option> -->
				<!-- 						<option value="2">13px</option> -->
				<!-- 						<option value="3">16px</option> -->
				<!-- 						<option value="4">18px</option> -->
				<!-- 						<option value="5">24px</option> -->
				<!-- 						<option value="6">32px</option> -->
				<!-- 						<option value="7">48px</option> -->
				<!-- 					</select> <select id="select-font-name"> -->
				<!-- 						<option value="">폰트</option> -->
				<!-- 						<option value="Black Han Sans">Black Han Sans</option> -->
				<!-- 						<option value="Noto Sans KR">Noto Sans</option> -->
				<!-- 						<option value="Nanum Gothic">Nanum Gothic</option> -->
				<!-- 						<option value="Nanum Myeongjo">Nanum Myeongjo</option> -->
				<!-- 						<option value="Nanum Pen Script">Nanum Pen Script</option> -->
				<!-- 					</select> <select id="select-font-color"> -->
				<!-- 						<option value="">폰트 색상</option> -->
				<!-- 						<option value="#000000">검정</option> -->
				<!-- 						<option value="#FFFFFF">흰색</option> -->
				<!-- 						<option value="#CCCCCC">회색</option> -->
				<!-- 						<option value="#F03E3E">빨강</option> -->
				<!-- 						<option value="#1971C2">파랑</option> -->
				<!-- 						<option value="#37B24D">녹색</option> -->
				<!-- 					</select> <select id="select-font-background"> -->
				<!-- 						<option value="rgba(0, 0, 0, 0)">폰트 백그라운드</option> -->
				<!-- 						<option value="#000000">검정</option> -->
				<!-- 						<option value="#FFFFFF">흰색</option> -->
				<!-- 						<option value="#CCCCCC">회색</option> -->
				<!-- 						<option value="#F03E3E">빨강</option> -->
				<!-- 						<option value="#1971C2">파랑</option> -->
				<!-- 						<option value="#37B24D">녹색</option> -->
				<!-- 					</select> <input id="img-selector" type="file" accept="image/*" /> -->
				<%-- 					<div id="insert_content" name="content" contenteditable="true">${vo2.content}</div> --%>
				<!-- 				</div> -->
				<div>
					<textarea id="insert_content" name="content">${vo2.content}</textarea>
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

	<script>
		const editor = document.getElementById('editor');
		const btnBold = document.getElementById('btn-bold');
		const btnItalic = document.getElementById('btn-italic');
		const btnUnderline = document.getElementById('btn-underline');
		const btnStrike = document.getElementById('btn-strike');
		const btnOrderedList = document.getElementById('btn-ordered-list');
		const btnUnorderedList = document.getElementById('btn-unordered-list');

		btnBold.addEventListener('click', function() {
			setStyle('bold');
		});

		btnItalic.addEventListener('click', function() {
			setStyle('italic');
		});

		btnUnderline.addEventListener('click', function() {
			setStyle('underline');
		});

		btnStrike.addEventListener('click', function() {
			setStyle('strikeThrough')
		});

		btnOrderedList.addEventListener('click', function() {
			setStyle('insertOrderedList');
		});

		btnUnorderedList.addEventListener('click', function() {
			setStyle('insertUnorderedList');
		});

		function setStyle(style) {
			document.execCommand(style);
			focusEditor();
		}

		// 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌
		function focusEditor() {
			editor.focus({
				preventScroll : true
			});
		}
	</script>

	<script>
		const btnImage = document.getElementById('btn-image');
		const imageSelector = document.getElementById('img-selector');

		btnImage.addEventListener('click', function() {
			imageSelector.click();
		});

		imageSelector.addEventListener('change', function(e) {
			const files = e.target.files;
			if (!!files) {
				insertImageDate(files[0]);
			}
		});

		function insertImageDate(file) {
			const reader = new FileReader();
			reader.addEventListener('load', function(e) {
				focusEditor();
				document.execCommand('insertImage', false, `${reader.result}`);
			});
			reader.readAsDataURL(file);
		}
	</script>

	<script>
		editor.addEventListener('keydown', function() {
			checkStyle();
		});

		editor.addEventListener('mousedown', function() {
			checkStyle();
		});

		function setStyle(style) {
			document.execCommand(style);
			focusEditor();
			checkStyle();
		}

		function checkStyle() {
			if (isStyle('bold')) {
				btnBold.classList.add('active');
			} else {
				btnBold.classList.remove('active');
			}
			if (isStyle('italic')) {
				btnItalic.classList.add('active');
			} else {
				btnItalic.classList.remove('active');
			}
			if (isStyle('underline')) {
				btnUnderline.classList.add('active');
			} else {
				btnUnderline.classList.remove('active');
			}
			if (isStyle('strikeThrough')) {
				btnStrike.classList.add('active');
			} else {
				btnStrike.classList.remove('active');
			}
			if (isStyle('insertOrderedList')) {
				btnOrderedList.classList.add('active');
			} else {
				btnOrderedList.classList.remove('active');
			}
			if (isStyle('insertUnorderedList')) {
				btnUnorderedList.classList.add('active');
			} else {
				btnUnorderedList.classList.remove('active');
			}
		}

		function isStyle(style) {
			return document.queryCommandState(style);
		}
	</script>

</body>
</html>