<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page session="false" %>
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
            <button type="button"><a href="/join_insert.do">글쓰기</a></button>
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
                                        <strong>닉네임</strong>
                                        <span>
                                            <button type="button">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </span>
                                    </div>

                                    <p>YYYY-MMMM-DDDD</p>
                                    
                                    <div class="com_func">
                                        <input type="text" placeholder="댓글 목록" id="join_comments">
                                        
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        

                    </li>
                    <li>
                        <div class="user_info">
                            <div class="user_info_profile_">
                                <div class="profile">
                                    <i class="far fa-user"></i>
                                </div>
                                <div class="user_info_profile_tooltip">
                                    <div class="com_top">
                                        <strong>닉네임</strong>
                                        <span>
                                            <button type="button">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </span>
                                    </div>

                                    <p>YYYY-MMMM-DDDD</p>
                                    
                                    <div class="com_func">
                                        <input type="text" placeholder="댓글 목록" id="join_comments">
                                        
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        

                    </li>
                    <li>
                        <div class="user_info">
                            <div class="user_info_profile_">
                                <div class="profile">
                                    <i class="far fa-user"></i>
                                </div>
                                <div class="user_info_profile_tooltip">
                                    <div class="com_top">
                                        <strong>닉네임</strong>
                                        <span>
                                            <button type="button">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </span>
                                    </div>

                                    <p>YYYY-MMMM-DDDD</p>
                                    
                                    <div class="com_func">
                                        <input type="text" placeholder="댓글 목록" id="join_comments">
                                        
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        

                    </li>
                    
                    
                    
                </ul>
                <div class="join_commnets_insert_section">
                    <div class="comments_user_profile">
                        <div class="commnets_user_profile_img">
                            <i class="far fa-user"></i>
                        </div>
                        <p>닉네임</p>
                    </div>
                    <input type="text" placeholder="댓글 작성">
                    <button type="button">댓글 작성</button>

                </div>
            </span>

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