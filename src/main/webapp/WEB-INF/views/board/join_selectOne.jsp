<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/board.css">
    <link rel="stylesheet" href="resources/css/board_min.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>

<jsp:include page="../top_menu.jsp"></jsp:include>

<div class="join_section">
    <jsp:include page="./som_top_menu.jsp"></jsp:include>
    <div class="top_func">
        <button type="button"><a href="join_insert.do">글쓰기</a></button>
    </div>
    <div class="view_content" style="height: auto; border: 1px solid #ccc; border-radius: 5px; margin-bottom: 50px;">
        <div class="join_top">
            <div class="user_info">
                <div class="profile">
                    <i class="far fa-user"></i>
                </div>
                <span>
                    <strong>${vo2.user_id}</strong>
                    <p>${vo2.write_date}</p>
                </span>
            </div>
            <div class="bbs_func">
                <button type="button">
                    <i class="fa-solid fa-lightbulb" style="color: red;"></i>
                </button>
                <button type="button">
                    <i class="far fa-heart"></i>
                </button>
                <button type="button">
                    <i class="fas fa-edit"></i>
                </button>
                <button type="button">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </div>
        <div class="content_text">
            <strong>제목: ${vo2.title}</strong>
            <p>내용: ${vo2.content}</p>
        </div>
    </div>
    <div class="comments_sec">
        <h3>댓글</h3>
        <c:forEach items="${coms}" var="com">


            <span>
                <ul class="com_grid">
                    <li>
                        <div class="user_info">
                            <div class="user_info_profile_">
                                <div class="profile">
                                    <i class="far fa-user"></i>
                                </div>
                                <div class="user_info_profile_tooltip">
                                    <div class="com_top">
                                        <strong>${com.user_id}</strong>
                                        <span>
                                            <form action="som_comm_updateOK.do">
                                                <input type="hidden" name="som_board_num" value="${com.som_board_num}">

                                            <button type="submit">
                                                <i class="fas fa-edit"></i>
                                                <%-- 수정 --%>

                                            </button>
                                                </form>
                                            </form >
                                            <form action="som_comm_deleteOK.do">
                                                <input type="hidden" name="som_board_num" value="${com.som_board_num}">
                                            <button type="submit">
                                                <i class="fas fa-trash-alt"></i>
                                                <%-- 삭제 --%>
                                            </button>
                                            </form>
                                        </span>
                                    </div>
                                    <p>${com.write_date}</p>
                                    <div class="com_func">
                                        <h4>댓글${com.user_id}</h4>
                                        <input type="text" placeholder="댓글 목록" value="${com.content}"
                                               id="join_comments">
                                    </div>
                                <c:forEach var="c_com" items="${c_coms}">
                                    <c:if test="${c_com.parent_com eq com.num}">
                                        <div class="com_func" style="width: auto; margin: 0 0; margin-left: 50px; ">
                                            <h5>${c_com.user_id}</h5>
                                            <input type="text" placeholder="댓글 목록" value="${c_com.content}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <form action="som_dcomm_insertOK.do">
                                    <div class="join_commnets_insert_section">
                                        <input type="text" placeholder="댓글 작성" name="content" value="${com.content}">
                                        <input type="hidden" name="parent_com" value="${com.num}">
                                        <input type="hidden" name="user_id" value="${user_id}">

                                        <input type="hidden" name="som_board_num" value="${com.som_board_num}">
                                        <input type="hidden" name="somoim_num" value="${com.somoim_num}">
                                        <button type="submit">댓글 작성</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </li>
                </ul>
            </span>
        </c:forEach>
        <form action="som_comm_insertOK.do?som_board_num=${vo2.num}">
        <div class="join_commnets_insert_section">
            <div class="comments_user_profile">
                <div class="commnets_user_profile_img">
                    <i class="far fa-user"></i>
                </div>
                <p>닉네임</p>
            </div>
                <input type="hidden" name="som_board_num" value="${vo2.num}">
                <input type="hidden" name="somoim_num" value="${vo2.somoim_num}">
                <input type="hidden" name="num" value="${vo2.num}">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="text" placeholder="댓글 작성" name="content">
<%--                <input type="hidden" name="som_member_num" value="#{vo2.som_member_num}">--%>

                <button type="submit">댓글 작성</button>
       </div>
        </form>
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
