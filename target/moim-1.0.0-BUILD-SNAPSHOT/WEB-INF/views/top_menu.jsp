<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

    
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
<div class="header">
        <div class="gnb">
            <div class="logo">
                <a href="home.do"><img src="resources/uploadimg/logo.png"></a>
            </div>
            <nav>
                <ul>
                    <li><a>원데이</a></li>
                    <li><a href="som_selectAll.do">소모임</a></li>
                    <li><a href="eventSelectAll.do">이벤트</a></li>
                    <li><a href="community_selectAll.do">커뮤니티</a></li>
                    <li><a href="cs_notice.do">고객센터</a></li>
                </ul>
            </nav>
            <div class="main_search">
                <input type="search" placeholder="검색">
            </div>
            <div class="login">
           		<a href="mypage.do">${user_id } 님</a> 
                <a href="login.do">로그인</a>
                <a href="logout.do">로그아웃</a>
            </div>

        </div>

    </div>
    
    <script type="text/javascript">
	if('${user_id}'===''){
		console.log('로그인풀림');
// 		$('.loginCheck').hide();
		$("a[href='mypage.do']").hide();
		$("a[href='logout.do']").hide();
		
	}else{
		$("a[href='login.do']").hide();
	}
    </script>
    