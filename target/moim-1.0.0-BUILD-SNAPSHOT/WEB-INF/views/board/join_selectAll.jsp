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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        var currentPage = 1; // 시작 페이지 번호
        var itemsPerPage = 3; //표시 항목 수

        $(".more_but").click(function() {
            currentPage++; // 페이지 번호 증가
            loadMoreItems();
        });

        function loadMoreItems() {

            var somoim_num = "${param.somoim_num}";
            var url = "/json_join_selectAll.do?somoim_num=" + somoim_num;
            $.ajax({
                url: url, // json 목록 가져오기
                method: "GET",
                data: { page: currentPage, itemsPerPage: itemsPerPage },
                dataType: "json",
                success: function(response) {
                    console.log("ajax on");
                    console.log("response", response);
                    //불러온 항목 처리 및 가공, 출력(html에 추가)
                    var items = response;
                    var html = "";
                    var startIndex = (currentPage - 1) * itemsPerPage;
                    var endIndex = startIndex + itemsPerPage;

                    if (startIndex >= items.length) {
                        // 요청한 페이지에 추가 항목이 없는 경우
                        $(".more_but").hide();
                        alert("모든 게시글을 표시했습니다!");

                        return;
                    }

                    if (endIndex > items.length) {
                        // 마지막 페이지에서 아이템의 인덱스 조정
                        endIndex = items.length;
                    }

                    for (var i = startIndex; i < endIndex; i++) {
                        var vo = items[i];
                        console.log("vo[i]...{}", vo);
                        console.log("vouser_id...{}", vo.user_id);
                        html += '<li>';
                        html += '    <input type="hidden" value="' + vo.som_member_num + '">';
                        html += '    <a href="join_selectOne.do?num=' + vo.num + '">';
                        html += '        <input type="hidden" value="' + vo.somoim_num + '">';
                        html += '        <div class="join_top">';
                        html += '            <div class="user_info">';
                        html += '                <div class="profile">';
                        html += '                    <img style="object-fit: cover; width: 100%; height: 100%; border-radius: 50%;" src="resources/uploadimg/' + vo.save_name + '">';
                        html += '                </div>';
                        html += '                <span>';
                        html += '                    <strong>' + vo.user_id + '</strong>  <div><i style="color: red" class="far fa-heart">' + vo.good_count + '</i></div>';
                        html += '                    <p>' + vo.write_date + '</p>';
                        html += '                </span>';
                        html += '            </div>';
                        html += '            <div class="bbs_func">';
                        <%--if (vo.user_id === ${user_id}) {--%>
                            html += '                <button type="button">';
                            html += '                    <a href="join_update.do?num=' + vo.num + '"><i class="fas fa-edit"></i></a>';
                            html += '                </button>';
                            html += '                <button type="button">';
                            html += '                    <a href="join_deleteOK.do?num=' + vo.num + '&somoim_num=' + vo.somoim_num + '"><i class="fas fa-trash-alt"></i></a>';
                            html += '                </button>';
                        // }
                        html += '            </div>';
                        html += '        </div>';
                        html += '        <div class="content_text">';
                        html += '            <strong>제목: ' + vo.title + '</strong>';
                        html += '            <p>내용:<br>';
                        // if (vo.save_name != null) {
                        //     html += '                <img src="resources/uploadimg/' + vo.save_name + '">';
                        // }
                        html += '                <br>';
                        html += '                ' + vo.content + '</p>';
                        html += '        </div>';
                        html += '    </a>';
                        html += '</li>';
                    }

                    $(".loopAjax").append(html);
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        }
    });
</script>

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
                <c:forEach var="vo" items="${vos}" varStatus="loop">
                        <c:if test="${loop.index < 3}">

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
                                        <strong>${vo.user_id}</strong>  <div ><i style="color: red" class="far fa-heart">${vo.good_count}</i></div>


                                        <p>${vo.write_date}</p>
                                    </span>
                                </div>
                                <div class="bbs_func">
                                    <c:if test="${vo.user_id == user_id}">
                                        <button type="button">
                                            <a href="join_update.do?num=${vo.num}"><i class="fas fa-edit"></i></a>
                                        </button>
                                        <button type="button">
                                            <a href="join_deleteOK.do?num=${vo.num}&somoim_num=${vo.somoim_num}"><i class="fas fa-trash-alt"></i></a>
                                        </button>
                                    </c:if>

                                </div>
                            </div>

                                <div class="content_text">
                                    <strong>제목:   ${vo.title}</strong>
                                    <p>내용:
                                        <br>
                                        <c:if test="${vo.save_name != null}">
                                            <img src="resources/uploadimg/${vo.save_name}">
                                        </c:if>
                                        <br>
                                        ${vo.content}
                                    </p>
                                </div>
                        </a>

                    </li>
                    </c:if>
                </c:forEach>
<div class="loopAjax">

</div>


            </ul>

        </div>

        <div class="more_but_position">
            <button class="more_but">더 보기 ></button>
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