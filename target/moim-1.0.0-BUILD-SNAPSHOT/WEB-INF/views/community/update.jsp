<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet"/>

    <title>Document</title>

</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>

<form action="community_updateOK.do" method="post"
      enctype="multipart/form-data">
    <div class="community_section">
        <div class="c_insert_func"></div>
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
                <div class="editor-menu">
                    <button type="button" id="btn-bold">
                        <b>B</b>
                    </button>
                    <button type="button" id="btn-italic">
                        <i>I</i>
                    </button>
                    <button type="button" id="btn-underline">
                        <u>U</u>
                    </button>
                    <button type="button" id="btn-strike">
                        <s>S</s>
                    </button>
                    <button type="button" id="btn-image">IMG</button>
                    <input id="img-selector" type="file" accept="image/*"/>
                </div>
                <div id="insert_content" contenteditable="true">${vo2.content}
                <input type="hidden" id="hidden_content" name="content"
                       value="${vo2.content}">
                <img src="resources/uploadimg/${vo2.save_name}"></div>
                <!-- Hidden input field to store the content -->
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
    document.getElementById("btn-image").addEventListener("click",
        function () {
            document.getElementById("img-selector").click();
        });

    document.getElementById("img-selector").addEventListener("change",
        function () {
            var file = this.files[0];
            // 선택된 파일을 처리하는 로직을 추가할 수 있습니다.
            console.log(file);
        });
</script>

<script>
    document.getElementById('img-selector').addEventListener(
        'change',
        function (e) {
            var file = e.target.files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                var img = document.createElement('img');
                img.src = reader.result;
                document.getElementById('insert_content').appendChild(
                    img);
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = "";
            }
        });

    function clearContent() {
        document.getElementById('insert_content').innerHTML = '';
    }
</script>

<script>
    // Update the value of the hidden input field with the content of the editable div
    document.getElementById("insert_content").addEventListener("input", function () {
        var content = this.innerHTML;
        document.getElementById("hidden_content").value = content;
    });

    const btnBold = document.getElementById('btn-bold');
    const btnItalic = document.getElementById('btn-italic');
    const btnUnderline = document.getElementById('btn-underline');
    const btnStrike = document.getElementById('btn-strike');
    const btnImage = document.getElementById('btn-image');
    const imageSelector = document.getElementById('img-selector');

    btnBold.addEventListener('click', function () {
        setStyle('bold');
    });

    btnItalic.addEventListener('click', function () {
        setStyle('italic');
    });

    btnUnderline.addEventListener('click', function () {
        setStyle('underline');
    });

    btnStrike.addEventListener('click', function () {
        setStyle('strikeThrough');
    });

    function setStyle(style) {
        document.execCommand(style);
        focusEditor();
    }

    // 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌
    function focusEditor() {
        document.getElementById("insert_content").focus({
            preventScroll: true
        });
    }
</script>

</body>
</html>