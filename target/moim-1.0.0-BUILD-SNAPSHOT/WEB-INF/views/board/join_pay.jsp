<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/board.css">
    <link rel="stylesheet" href="resources/css/pay.css">
    <link rel="stylesheet" href="resources/css/board_min.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
    <jsp:include page="../top_menu.jsp"></jsp:include>

<div class="join_section">
    <jsp:include page="./som_top_menu.jsp"></jsp:include>

    <div class="payment_section">
        <ul class="payment_main_grid">
            <li>
                <div class="payment_left">
                    <span>
                        <h3>일정 제목</h3>
                        <p>총 금액: </p>
                        <p>1인당 금액: </p>
                        <button type="button" id="payment_btn">정산하기</button>
                    </span>
                </div>
                <div class="payment_right">
                    <h3>참여 멤버</h3>
                    <ul id="member-list">
                        <!-- Member list will be populate   d by JavaScript -->
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                        <li>
                            <i class="far fa-user"></i>
                        </li>
                    </ul>
                    <div class="show-more-div">
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
<script src="../js/pay.js"></script>
</html>
