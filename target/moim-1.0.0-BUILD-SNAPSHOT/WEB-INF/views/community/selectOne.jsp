<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/community.css">

<script src="https://kit.fontawesome.com/1652357a48.js"
	crossorigin="anonymous"></script>
<title>Document</title>
</head>
<body>


	<jsp:include page="../top_menu.jsp"></jsp:include>

	<div class="community_section">

		<div class="c_view_content"
			style="height: auto; border: 1px solid #ccc; border-radius: 5px; margin-bottom: 50px;">

			<div class="community_top">
				<div class="c_user_info">
					<div class="c_profile">
						<i class="far fa-user"></i>
					</div>
					<span> <strong>${vo2.user_id}</strong>
						<p>${vo2.write_date}</p>
					</span>
				</div>
				<div class="c_bbs_func">
					<button type="button">
						<i class="far fa-heart"></i>
					</button>
					<a href="community_update.do?num=${param.num}" class="button-link">
						<button type="button" class="edit-button">
							<i class="fas fa-edit"></i>
						</button>
					</a> <a href="community_deleteOK.do?num=${param.num}"
						class="button-link">
						<button type="button" class="delete-button">
							<i class="fas fa-trash-alt"></i>
						</button>
					</a>
				</div>
			</div>
			<div class="c_content_text">
				<img src="resources/uploadimg/${vo2.save_name}">
				</br>
				<strong>${vo2.title}</strong>

				<p>${vo2.content}</p>

			</div>
		</div>
		<div class="c_comments_sec">
			<h3>댓글</h3>
			<c:forEach items="${ccoms}" var="ccoms">
			<span>
				<ul class="c_com_grid">
					<li>
						<div class="c_user_info">
							<div class="c_user_info_profile_">
								<div class="c_profile">
									<i class="far fa-user"></i>
								</div>
								<div class="c_user_info_profile_tooltip">
									<div class="c_com_top">
										<strong>${ccoms.user_id}</strong>
										<span>
											<form action="Community_comments_updateOK.do?num=${ccoms.num}">
												<input type="hidden" name="board_num" value="${ccoms.board_num}">
                                                <input type="hidden" name="num" value = "${ccoms.num}">
                                                <input type="hidden" name="content" value = "${ccoms.content}">
											<button type="submit">
												<i class="fas fa-edit"></i>
												<%-- 수정 --%>
											</button>
											</form>
											<form action="Community_comments_deleteOK.do?num=${ccoms.num}">
												<input type="hidden" name="board_num" value="${ccoms.board_num}">
                                                <input type="hidden" name="num" value="${ccoms.num}">
											<button type="submit">
												<i class="fas fa-trash-alt"></i>
												<%-- 삭제 --%>
											</button>
											</form>
										</span>
									</div>
									<p>${ccoms.write_date}</p>
									<div class="c_com_func">
										<h4>댓글${ccoms.user_id}</h4>
										<input type="text" placeholder="댓글 목록" value="${ccoms.content}"
											   id="community_comments">
									</div>
									<c:forEach var="c_com" items="${c_coms}">
										<c:if test="${c_com.parent_com eq ccoms.num}">
                                        <div class="c_com_func" style="width: auto; margin: 0 0; margin-left: 50px; ">
                                            <h5>${com.num.user_id}</h5>
                                            <input type="text" placeholder="댓글 목록" value="${c_com.content}">
                                        </div>
										</c:if>
									</c:forEach>
									<form action="Community_re_comments_insertOK.do">
                                    <div class="community_commnets_insert_section">
                                        <input type="text" placeholder="댓글 작성" name="content" value="${c_com.content}">
                                        <input type="hidden" name="parent_com" value="${ccoms.num}">
                                        <input type="hidden" name="user_id" value="${user_id}">
                                        <input type="hidden" name="board_num" value="${ccoms.board_num}">
                                        <button type="submit">댓글 작성</button>
                                    </div>
                                	</form>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</span>
			</c:forEach>
			<form action="Community_comments_insertOK.do?num=${vo2.num}">
				<div class="community_commnets_insert_section">
					<div class="c_comments_user_profile">
						<div class="c_commnets_user_profile_img">
							<i class="far fa-user"></i>
						</div>
						<p>닉네임</p>
					</div>
					<input type="hidden" name="board_num" value="${vo3.board_num}">
					<input type="hidden" name="num" value="${vo3.num}">
					<input type="hidden" name="user_id" value="${user_id}">
					<input type="text" placeholder="댓글 작성" name="content">
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