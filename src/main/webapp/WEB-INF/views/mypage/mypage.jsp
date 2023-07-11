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
    <link rel="stylesheet" href="resources/css/mypage.css">
    <link rel="stylesheet" href="resources/css/mypage_min.css">
    <script src="https://kit.fontawesome.com/1652357a48.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>
    <div class="mypage_sec">
        <div class="mypage_top_sec">
            <div class="mypage_left_profile">
                <div class="mypage_myprofile">
                    <img src="resources/uploadimg/${vo2.save_name }" width="220" height="220">
                    
                </div>
                <button type="button" id="update_profile"><a href="mypage_update.do">프로필 편집</a></button>
​
            </div>
            <div class="mypage_right_info">
                <ul class="mypage_grid">
                    <li>
                        <h2>이름/아이디</h2>
                        <p>${vo2.name } / ${vo2.user_id }</p>
                    </li>
                    <li>
                        <h2>보유 포인트</h2>
                        <p>${vo2.point }</p>
                    </li>
                    <li>
                        <h2>이메일</h2>
                        <p>${vo2.email }</p>
                    </li>
                    <li>
                        <h2>나의 생일</h2>
                        <p>${vo2.birthday }</p>
                    </li>
                    <li>
                        <a href="mypage_myactivity_good.do">나의 활동</a>
                    </li>
                    <li>
                        <a href="#">내 피드 들어가기</a>
                    </li>
​
                </ul>
            </div>
        </div>
        <div class="mypage_center_sec">
            <h2>나의 모임</h2>
            <ul class="mypage_grid02">
                <li>
                    <div class="mypage_moim_profile">
                        dgdgdg
​
                    </div>
                    <p>카테고리</p>
​
                </li>
                <li>
                    <div class="mypage_moim_profile">
                        dgdgdg
​
                    </div>
                    <p>카테고리</p>
​
                </li>
                <li>
                    <div class="mypage_moim_profile">
                        dgdgdg
​
                    </div>
                    <p>카테고리</p>
​
                </li>
                <li>
                    <div class="mypage_moim_profile">
                        <i class="fas fa-plus"></i>
​
                    </div>
                   <a href="som_selectAll.do"><button type="button">새 모임 추가</button></a> 
​
​
                </li>
            </ul>
        </div>
        <div class="mypage_bottom_sec">
            <h2>
                쪽지함
            </h2>
            <ul class="mypage_grid03">
                <li>
                    <div class="note_title">
                        <strong>영혼의 숨겨(user_id)</strong>
                        <br>
                        <a>답장하기</a>
                        <a>신고하기</a>
                        <a>삭제하기</a>
                    </div>
                    <div class="note_content">
                        그날이 오고 있습니다...
                    </div>
                    <div class="note_date">
                        방금 전
                    </div>
                </li>
                <li>
                    <div class="note_title">
                        <strong>영혼의 숨겨(user_id)</strong>
                        <br>
                        <a>답장하기</a>
                        <a>신고하기</a>
                        <a>삭제하기</a>
                    </div>
                    <div class="note_content">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem temporibus pariatur quod, velit optio nisi aliquam a ipsa asperiores vel obcaecati id esse! Vitae repellendus iste molestiae aspernatur sunt in.
                    </div>
                    <div class="note_date">
                        방금 전
                    </div>
                </li>
                </li>
                <li>
                    <div class="note_title">
                        <strong>영혼의 숨겨(user_id)</strong>
                        <br>
                        <a>답장하기</a>
                        <a>신고하기</a>
                        <a>삭제하기</a>
                    </div>
                    <div class="note_content">
                        그날이 오고 있습니다ffffffffffffff...
                    </div>
                    <div class="note_date">
                        방금 전
                    </div>
                </li>
​
​
            </ul>
​
        </div>
​
​
    </div>
​
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
​
    </div>
</body>
</html>