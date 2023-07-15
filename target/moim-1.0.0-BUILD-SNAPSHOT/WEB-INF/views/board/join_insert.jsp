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

    <div class="insert_func">
            <span>
                <i class="fas fa-vote-yea"><a id="vote_link">투표</a></i>
                <i class="fas fa-image"><a>이미지</a></i>
                <i class="fas fa-file-alt"><a>파일</a></i>


            </span>

    </div>
    <div class="join_insert_secction">
        <form id="insert_form" enctype="multipart/form-data" method="POST">
            <span>

                    <h2>제목</h2>
                    <input type="text" placeholder="제목을 입력하세요" id="insert_title" name="title">

                    <h2>내용</h2>
                    <div contenteditable="true"
                         style="width: 100%; height: 620px; border-radius:5px; padding: 8px; border: #ccc solid 1px; outline: none; resize: none; text-align: left;margin-top: 20px;"
                         id="insert_content" name="content">




                    </div> <%--contenteditable 종료 부분--%>

                    <h2>작성자</h2>
                    <input type="text" style="background-color: #ccc;" value="${user_id}" id="insert_id" name="user_id" readonly/>


                    <input type="file" name="file" id="insert_imageUpload" style="display: none;" onchange="image_done()">
                    <input type="hidden" value="${num}" id="insert_num" name="somoim_num">



            </span>
            <div class="form_span">
                <button type="button" onclick="join_insertOK()">작성완료</button>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/board.js"></script>
<script src="resources/js/vote.js"></script>

<script type="text/javascript">
    $('.fa-image').on('click', function() {
        $('#insert_imageUpload').click();
    });

    function image_done(){
        alert("이미지가 추가되었습니다.");
    }

    $(document).ready(function(){
        $("#vote_link").click(function(e){
            console.log("투표 기능");
            e.preventDefault();
            var voteSection =
                '<div contenteditable="false">'+
                '<div class="vote_section">' +
                '<div class="vote_detail_seciton">' +
                '<h2>투표 제목</h2>' +
                '<input type="text" placeholder="투표 제목을 입력하세요" class="vote_title">' +
                '<ul class="vote_grid">' +
                '<li>' +
                '<button type="button">' +
                '<input type="text" placeholder="투표 항목" class="vote_items">' +
                '</button>' +
                '</li>' +
                '<li>' +
                '<button type="button">' +
                '<input type="text" placeholder="투표 항목" class="vote_items">' +
                '</button>' +
                '</li>' +
                '</ul>' +
                '</div>' +
                '<div class="vote_function">' +
                '<span class="vote_function_class">' +
                '<a id="add_votetable">항목 추가</a>' +
                '<a id="delete_votetable">투표 삭제</a>' +
                '</span>' +
                '<button type="button" id="make_vote">투표 만들기</button>' +
                '</div>' +
                '</div>' +
                '</div>';


            $("#insert_content").html(voteSection);
        });

        // 이벤트 위임을 사용하여 동적으로 추가된 delete_votetable에 클릭 이벤트를 적용합니다.
        $("#insert_content").on('click', '#delete_votetable', function(e){
            e.preventDefault();
            $(".vote_section").remove();
        });

        // 이벤트 위임을 사용하여 동적으로 추가된 add_votetable에 클릭 이벤트를 적용합니다.
        $("#insert_content").on('click', '#add_votetable', function(e){
            e.preventDefault();
            $(".vote_grid").append('<li><button type="button"><input type="text" placeholder="투표 항목" class="vote_items"></button></li>');
        });

        $("#insert_content").on('click', '#make_vote', function(e){

            var user_id = $('#insert_id').val();
            var vote_title = $('.vote_title').val();
            var somoim_num = $('#insert_num').val();

            alert(somoim_num);

            $.ajax({
                url: "vote_insertOK.do",
                data: {
                    user_id: user_id,
                    question: vote_title,
                    somoim_num: somoim_num,
                },
                method: 'POST',
                dataType: 'text',
                success: function(response) {
                    console.log('ajax....success', response);
                    alert("투표가 등록되었습니다.");
                    console.log("current_num"+response);
                    var currnet_num = response.valueOf();
                    vote_items(currnet_num);


                },
                error:function(xhr,status,error){
                    console.log('xhr.status:', xhr.status);
                }
            });//end ajax

            function vote_items(current_num) {
                $('.vote_items').each(function() {
                    var voteItem = $(this).val();

                    $.ajax({
                        url: "choice_insertOK.do",  // Add your request URL here
                        data: {
                            som_qvote_num: current_num,
                            choice: voteItem,
                            somoim_num: $('#insert_num').val()
                            // Pass the input field value as a data
                        },
                        method: 'POST',
                        dataType: 'text',
                        success: function(response) {
                            console.log('ajax....success', response);
                            console.log("current_num" + response);
                        },
                        error: function(xhr,status,error) {
                            console.log('xhr.status:', xhr.status);
                        }
                    }); //end ajax
                }); //end each
            }





        });//end function



    });//end document ready


</script>

</html>