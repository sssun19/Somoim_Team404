<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="UTP-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/board.css">
    <link rel="stylesheet" href="resources/css/board_min.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/board.js"></script>

    <script type="text/javascript">
        $(function(){
            console.log('onload.......');
            $.ajax({
                url:'som_member_profileCheck.do',
                method:'GET',
                data: {
                    num:${param.num}
                },
                success: function(data){
                    console.log('ajax successed...');
                    console.log('data : ', data);

                    let tag_vo = '';
                    $.each(data,function(index,vo){
                        console.log(index,vo);
                        console.log('save_name : ', vo.save_name);
                        tag_vo += `
                        <li>
                            <div class="round_box">
                                <img src="resources/uploadimg/\${vo.save_name}" width="50"; height="50"; style="border-radius:25px;" >
                            </div>
                        </li>
        			`;
                    });



                    $('#img_members').html(tag_vo);
                },
                error : function(xhr, status, error){
                    console.log('xhr.status : ', xhr.status);
                }




            });//end ajax...
        });//end onload..


    </script>

</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>



<form action="som_member_insertOK.do" method="POST">
    <div class="join_section">
        <jsp:include page="./som_top_menu.jsp"></jsp:include>

        <div class="img_info">
            <img src="resources/uploadimg/${vo2.somoim_img}">
        </div>
        <div class="som_tit">
            <h1 class="main_tit" style="padding: 10px;">${vo2.som_title}</h1>
            <p style="font-weight: 600; color: #999";>카테고리: ${vo2.category} ㅣ 모임 정원: ${vo2.max_member} ㅣ 모임 개설일: ${vo2.create_date}</p>
            <p style="font-weight: 600; color: #999";>모임장: ${vo2.somoim_master }</p>

            <%--            <p>모임 개설일: ${vo2.create_date}</p>--%>
            <p>${vo2.som_content}</p>
        </div>
        <div class="join_member">
            <h1>가입한 멤버</h1>
            <ul id="img_members">
                <!--                 <li> -->
                <!--                     <div class="round_box"> -->
                <!--                         <i class="far fa-user"></i> -->
                <!--                     </div> -->
                <!--                 </li> -->
            </ul>

        </div>
        <div class="join_cal">
            <h1>일정</h1>
            <div class="cal_detail">
                <div class="detail_info">
                    <h1>06/17</h1>
                    <br>
                    <strong>서울여행</strong>

                    <p>일시: </p>
                    <p>장소: </p>
                    <p>회비: </p>
                    <p>참여: </p>
                </div>
                <div class="detail_member">
                    <h1>참석 멤버</h1>
                    <ul>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>
                        <li>
                            <div class="round_box">
                                <i class="far fa-user"></i>
                            </div>
                        </li>

                    </ul>
                </div>
                <div class="detail_status">
                    <button type="button"><a href="join_schedule.do?somoim_num=${vo2.num }">참석</a></button>
                </div>


            </div>
        </div>

        <input type="hidden" name="user_id" value="${user_id}">
        <input type="hidden" name="num" value="${vo2.num}">
        <input type="hidden" name="som_title" value="${vo2.som_title}">
        <input type="hidden" name="save_name" value="${uvo2.save_name}">
        <input type="submit" id="som_register" value="모임 가입하기">
        <br>
        <br>
        <a href="som_update.do"><input type="button" id="som_update" value="수정"></a>
        <a href="som_delete.do?num=${vo2.num }&user_id=${user_id}"><input type="button" id="som_delete" value="삭제"></a>

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

<<<<<<< HEAD
<script type="text/javascript">
if('${user_id}'==='${vo2.somoim_master}'){
	console.log('${user_id}')
	console.log('너 모임장이네!!');
	$('#som_update').show();
	$('#som_delete').show();
// 	$('#som_register').hide();
} else {
	console.log('아닌데?');
	$('#som_update').hide();
	$('#som_delete').hide();
}
=======
</div>

<script type="text/javascript">
    if('${user_id}'==='${vo2.somoim_master}'){
        console.log('${user_id}')
        console.log('너 모임장이네!!');
        $('#som_update').show();
        $('#som_delete').show();
// 	$('#som_register').hide();
    } else {
        console.log('아닌데?');
        $('#som_update').hide();
        $('#som_delete').hide();
    }
>>>>>>> c7bef14a72571994a25d4ec5ac62d0d51e6e903e
</script>


</body>
</html>