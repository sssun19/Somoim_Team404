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
    <script src="https://kit.fontawesome.com/1652357a48.js"
            crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet"/>
    <title>Document</title>


</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>

<form action="community_insertOK.do" method="post"
      enctype="multipart/form-data">
    <div class="community_section">
        <div class="c_insert_func">

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

                <div class="form-group">
                    <label for="image">IMG</label>
                    <input type="file" id="image" name="file" accept="image/*" onchange="previewImage();" />
                </div>
                <div class="preview_img_box">
                    <img id="imagePreview" src="" alt="Image Preview" style="display: none;"/>
                </div>
                <div>
                    <textarea name="content"></textarea>
                </div>



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
    function previewImage() {
        var file = document.querySelector('#image').files[0];
        var reader = new FileReader();

        reader.addEventListener("load", function () {
            // 변환된 이미지 URL을 img 태그의 src 속성에 할당
            document.querySelector('#imagePreview').src = reader.result;
            document.querySelector('#imagePreview').style.display = 'block';
        }, false);

        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>



</body>
</html>