<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Document</title>
</head>
<body>
        <jsp:include page="../top_menu.jsp"></jsp:include>

    <div class="join_section">
        <jsp:include page="./som_top_menu.jsp"></jsp:include>
        <div class="img_info">
            이미지
        </div>
        <div class="top_func">
            <button type="button"><a href="join_insert.do" style="color: white">글쓰기</a></button>
        </div> 
        <div class="view_content">
            <ul>
                <c:forEach var="vo" items="${vos}">
                    <li>
                        <input type="hidden" value="${vo.som_member_num}">
                        <a href="join_selectOne.do?num=${vo.num}">
                            <input type="hidden" value="${vo.somoim_num}">
                            <div class="join_top">
                                <div class="user_info">
                                    <div class="profile">
                                        <img style="  object-fit: cover; width: 100%; height: 100%; border-radius: 50%;"
                                             src="resources/uploadimg/${vo.save_name}">
                                    </div>
                                    <span>
                                        <strong>${vo.user_id}</strong>

                                        <p>${vo.write_date}</p>
                                    </span>
                                </div>
                                <div class="bbs_func">
                                    <button type="button">
                                        <a href="join_update.do?num=${vo.num}"><i class="fas fa-edit"></i></a>
                                    </button>
                                    <button type="button">
                                        <a href="join_deleteOK.do?num=${vo.num}&somoim_num=${vo.somoim_num}"><i class="fas fa-trash-alt"></i></a>
                                    </button>
                                </div>
                            </div>

                                <div class="content_text">
                                    <strong>제목:   ${vo.title}</strong>
                                    <p>내용:   ${vo.content}</p>
                                </div>
                        </a>

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
</html>