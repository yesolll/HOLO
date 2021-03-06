<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<head>
<style type="text/css">
.button_wrap .write{
   text-align: center;
   min-width: 80;
   padding: 10px;
   border: 1px solid #ddd;
   border-radius: 2px;
   font-size: 1.4rem;
   background: #1e57a4;
   color: #fff;
}   
</style>

<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_list_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
function confirmLevels(levelCheck) {
	if("${sessionScope.sessionId}" == ""){
		alert("로그인 후 글쓰기가 가능합니다.");
		location.href="/holo/member/loginForm.holo";

	}else{
		if(levelCheck){
			location.href="/holo/market/writeForm.holo?category_a=${category_a}&category_b=${category_b}";
		}else{
			alert("레벨 3부터 글쓰기가 가능합니다.");
		}
	}
 }
</script>

<title>중고 장터</title>
</head>

<body>
	<div class="board_wrap">
		<div class="board_title">
			<c:choose>
				<c:when test="${category_b eq 'sell'}">
					<strong><a href="/holo/market/list.holo?category_b=sell">중고장터 - 팝니다</a></strong>
					<p>중고물품을 사고 팔아보세요!</p>
				</c:when>
				<c:when test="${category_b eq 'buy'}">
					<strong><a href="/holo/market/list.holo?category_b=buy">중고장터 - 삽니다</a></strong>
					<p>중고물품을 사고 팔아보세요!</p>
				</c:when>
				<c:when test="${category_a eq 'free'}">
					<strong><a
						href="/holo/market/list.holo?category_a=free&category_b=b">무료나눔</a></strong>
					<p>안 쓰는 물건을 무료로 나눠주세요!</p>
				</c:when>
				<c:when test="${category_a eq 'group'}">
					<strong><a
						href="/holo/market/list.holo?category_a=group&category_b=b">공동구매</a></strong>
					<p>공동구매로 알뜰하게 구매해보세요!</p>
				</c:when>
			</c:choose>
			<br /><br />
			<c:if test="${category_a eq 'market'}">
		<div class="board_page">
				<a class="num" href="/holo/market/list.holo?category_b=sell"><b>팔기</b></a>
				<a class="num" href="/holo/market/list.holo?category_b=buy"><b>사기</b></a>
			</div>
			</c:if>
		</div>
		<br />

	<c:if test="${count == 0}">
		<div align="center">
			<h3>게시판에 저장된 글이 없습니다.</h3>
		</div>
	</c:if>
	<c:if test="${count >0}">
		<div class="board_list_wrap">
			<div class="board_list">
				<div class="top">
					<div class="num">번호</div>
					<div class="title">글제목</div>
					<div class="writer">작성자</div>
					<div class="date">작성일</div>
					<div class="count">조회수</div>
				</div>
						<c:forEach var="list" items="${articleList}">
						<div>
							<div class="num">
								<c:out value="${num}" />
								<c:set var="num" value="${num-1}" />
							</div>

							<div class="title">


								<a class="title"
									href="/holo/market/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
                                    ${list.subject}<c:if test="${list.repCount != 0}">[${list.repCount}]</c:if></a>
                            </div>
							<div class="writer"><a href="/holo/member/userInfo.holo?id=${list.id}">
							<img src="/holo/resource/image/level/${list.levels}.png" width="15" height="15"/>${list.id}</a></div>
							<div class="date">
								<fmt:formatDate value="${list.regDate}"
									pattern="yyyy-MM-dd hh:mm" />
							</div>
							<div class="count">${list.viewCount}</div>
							</div>
						</c:forEach>
				</div>
			<br />
		<div align="center">
			<form action="/holo/market/list.holo">
				<input type="hidden" name="pageNum" value="1" /> 
				<input type="hidden" name="category_a" value="${category_a}" /> 
				<input type="hidden" name="category_b" value="${category_b}" /> 
				<select name="choice">
					<option value="id">작성자</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select> <input type="text" name="search"> 
				<input type="submit" style="width:35px;height:22px;background-color: #1e57a4; color:#fff;border:none;"
					value="검색"> &nbsp;
				<c:if test="${not empty search}">
					<input type="button" value="검색 초기화"
						onclick="document.location.href='/holo/market/list.holo?category_a=${category_a}&category_b=${category_b}'" />
				</c:if>
			</form>
		</div>		
</div>
</c:if>
		<div class="board_page">
	
			<c:if test="${empty choice and empty search}">
				<a class="button first" href="/holo/market/list.holo?pageNum=1&category_a=${category_a}&category_b=${category_b}">처음</a>
				<c:if test="${startPage>5}">
					<a class="button prev"
						href="/holo/market/list.holo?pageNum=${startPage-1}&category_a=${category_a}&category_b=${category_b}">이전</a>
				</c:if>

				<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
					<a class="num"
						href="/holo/market/list.holo?pageNum=${pagenum}&category_a=${category_a}&category_b=${category_b}">${pagenum}</a>
				</c:forEach>

				<c:if test="${endPage < pageCount}">
					<a class="button next"
						href="/holo/market/list.holo?pageNum=${startPage+5}&category_a=${category_a}&category_b=${category_b}">다음</a>
				</c:if>
				<a class="button last"
					href="/holo/market/list.holo?pageNum=${pageCount}&category_a=${category_a}&category_b=${category_b}">맨끝</a>
			</c:if>

			<c:if test="${not empty choice and not empty search}">
				<a class="button first"
					href="/holo/market/list.holo?pageNum=1&category_a=${category_a}&category_b=${category_b}&choice=${choice}&search=${search}">처음</a>
				<c:if test="${startPage>5}">
					<a class="button prev"
						href="/holo/market/list.holo?pageNum=${startPage-1}&category_a=${category_a}&category_b=${category_b}&choice=${choice}&search=${search}">이전</a>
				</c:if>

				<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
					<a class="num"
						href="/holo/market/list.holo?pageNum=${pagenum}&category_a=${category_a}&category_b=${category_b}&choice=${choice}&search=${search}">${pagenum}</a>
				</c:forEach>

				<c:if test="${endPage < pageCount}">
					<a class="button next"
						href="/holo/market/list.holo?pageNum=${startPage+5}&category_a=${category_a}&category_b=${category_b}&choice=${choice}&search=${search}">다음</a>
				</c:if>
				<a class="button last"
					href="/holo/market/list.holo?pageNum=${pageCount}&category_a=${category_a}&category_b=${category_b}&choice=${choice}&search=${search}">맨끝</a>
			</c:if>
		</div>
		
		<div class="button_wrap">
			<input class="write" type="button"  onclick="confirmLevels(${levelCheck})" value="글작성" />
			<a href="/holo/member/main.holo" class="on">메인으로</a>
		</div>

	</div>
	<br />

</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>