<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
<div class="header">
        <div class="gnb">
            <div class="logo">
<<<<<<< HEAD
                <a href="home.do"><img src="${pageContext.request.contextPath}/resources/uploadimg/logo.png"></a>
=======
                <a href="home.do"><img src="resources/img/logo.png"></a>
>>>>>>> 9b8d951ab5815a89787e51749f4b0af4ab30b0fc
            </div>
            <nav>
                <ul>
                    <li><a>원데이</a></li>
                    <li><a href="som_selectAll.do">소모임</a></li>
                    <li><a>이벤트</a></li>
<<<<<<< HEAD
                    <li><a>커뮤니티</a></li>
=======
                    <li><a href="community_selectAll.do">커뮤니티</a></li>
>>>>>>> 9b8d951ab5815a89787e51749f4b0af4ab30b0fc
                    <li><a>고객센터</a></li>
                </ul>
            </nav>
            <div class="main_search">
                <input type="search" placeholder="검색">
            </div>
            <div class="login">
<<<<<<< HEAD

                <%
                    String user_id = (String) session.getAttribute("user_id");
                    if (user_id == null) {
                %>
                <a>${user_id}</a>
                <a href="login.do">로그인</a>
                <a href="logout.do">회원가입</a>
                <%
                } else {
                %>
                <a>${user_id}</a>
                <a href="mypage.do">마이페이지</a>
                <a href="logout.do">로그아웃</a>
                <%
                    }
                %>
=======
                <a href="login.do">로그인</a>
                <a href="logout.do">로그아웃</a>
>>>>>>> 9b8d951ab5815a89787e51749f4b0af4ab30b0fc
            </div>

        </div>

    </div>