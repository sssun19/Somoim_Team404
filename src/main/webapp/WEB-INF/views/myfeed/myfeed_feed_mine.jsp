<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/min.css">
    <link rel="stylesheet" href="resources/css/myfeed.css">
    <link rel="stylesheet" href="resources/css/myfeed_min.css">
    <link rel="stylesheet" href="resources/css/board.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="header">
        
	<jsp:include page="../top_menu.jsp"></jsp:include>

    </div>
    <div class="myfeed_sec">
        <div class="myfeed_top_sec">
            <div class="myfeed_left_profile">
                <div class="myfeed_myprofile" style="background-color:white"><img src="resources/uploadimg/${vo2.save_name }" style="height:120px; weight:120px;">
<!--                     <i class="far fa-user"></i> -->
				
                </div>
            </div>
            <div class="myfeed_right_info">
                <ul class="myfeed_grid">
                    <li>
                        <h2>${vo2.name }</h2>
                    </li>
                    <br/>
                    <li>#반려동물</li>
                    <li>#공연관람</li>
                </ul>
                <div class="top_follow" id="feed_mine">
                    <button type="button" style="padding: 5px 12px;">수정하기</button>
                    <button type="button" style="padding: 5px 12px;">사진추가</button>
                    <button type="button" style="padding: 5px 12px;">포인트샵</button>           
                </div>
                <div class="top_follow" id="feed_notmine">
                    <button type="button" style="padding: 5px 12px;">팔로우 하기</button>
                    <button type="button" style="padding: 5px 12px;">매너온도UP</button>
                    <button type="button" style="padding: 5px 12px;">신고하기</button>           
                </div>
                
                <div class="follower_following">
                    <span>팔로워: <strong>0</strong></span>
                    <span>팔로잉: <strong>0</strong></span>
                    <span>피드: <strong>9</strong></span>
                </div>
            </div>
        </div>
    </div>
</br>
    <div class="myfeed_group_menu">
        <ul>
            <li><a href="#">피드</a></li>
            <li><a href="#">모임</a></li>
        </ul>
    </div>
            
        </div>
        <div class="myfeed_bottom_sec">

        </div>

        <div class="join_feedbox">
            <ul class="feed_grid">
                <li>이미지 1</li>
                <li>이미지 2</li>
                <li>이미지 3</li>
                <li>이미지 4</li>
                <li>이미지 5</li>
                <li>이미지 5</li>
                <li>이미지 5</li>
                <li>이미지 5</li>
                <li>이미지 5</li>

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
    
    <script type="text/javascript">
    if('${param.user_id}'==='${vo2.user_id}') {
    	console.log('내가 피드 주인!');
    	$('#feed_mine').show();
    	$('#feed_notmine').hide();
    } else {
    	console.log('나는 구경꾼!');
    	$('#feed_notmine').show();
    	$('#feed_mine').hide();
    }
    
    </script>
</body>
</html>