<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/board.css">
    <link rel="stylesheet" href="resources/css/board_min.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
    <script src="/resources/js/schedule.js"></script>
    <title>Document</title>
</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>

<div class="join_section">
    <jsp:include page="./som_top_menu.jsp"></jsp:include>


    <div class="top_func">
        <button type="button" style="padding: 5px 12px;"><a href="join_schedule_insert.do" style="color: white">일정 만들기</a></button>
    </div>

    <div class="schedule_box">
        <ul class="sch_grid">
            <c:forEach items="${vos}" var="vo">
                <li>
                    <div class="sch_func">
                            <span>
                                <input type="hidden" value="${vo.num}" class="PART_UPDATE_NUM">
                                <input type="hidden" value="${vo.participant}" class="PART_UPDATE_Participant">
                                <input type="hidden" value="${user_id}" class="PART_UPDATE_USER_ID">
                                <button type="button" class="participant_btn" onclick="Participant_UpdateOK(this)">참석</button>
                                <button type="button" class="participant_cancle_btn">취소</button>
                            </span>
                        <span>
                                <button type="button">
                                    <a href="join_schedule_update.do?num=${vo.num}"><i class="fas fa-edit"></i></a>
                                </button>
                                <button type="button">
                                    <a href="join_schedule_delete.do?num=${vo.num}"><i class="fas fa-trash-alt"></i></a>
                                </button>
                            </span>

                    </div>
                    <div class="sch_content">
                        <div class="sch_info" style="text-align: left">


                            <h2>${vo.schedule_date}</h2>
                            <strong style="font-size: 20px;" >${vo.schedule_title}</strong>
                            <p>일시: ${vo.schedule_date}</p>
                            <p>장소: ${vo.place}</p>
                            <p>회비: ${vo.money}</p>

                        </div>
                        <div class="sch_member">
                            <h2 style="padding-bottom: 10px">참석 멤버</h2>
                            <ul class="schm_grid">
                                <c:forEach var="participant" items="${fn:split(vo.participant, '/')}" varStatus="status">
                                    <li>
                                        <i class="far fa-user"></i> <input type="hidden" value="${participant}" class="update_participant">
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>

                    </div>

                </li>
            </c:forEach>
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

<script>
    var message = "${message}"; // Model에서 전달된 메시지 가져오기

    if (message) {
        alert(message); // 메시지가 존재할 경우 알림 표시
    }
</script>

</html>
