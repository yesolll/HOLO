<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<!-- link 선언 -->
<link rel="stylesheet" href="/holo/resource/style/board_list_style.css">
<link rel="stylesheet" href="/holo/resource/style/main.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
$(function(){
	$(".btn-unScrap").click(function(){
		var articlenum = $(this).attr("articlenum");
		var boardname = $(this).attr("boardname");
		$.ajax({
			url:"/holo/unScrap.holo",type: "POST",async:false,
			data:{	articlenum: articlenum,
					boardname: boardname},
			success:function(){
				alert("삭제되었습니다.");
				history.go(0);
			}
		})
	})
})
</script>

</head>

<body>
   <div class="board_wrap"style="width:700px">
      <div class="board_title">
         <strong>스크랩 게시판</a></strong>
         <p>스크랩 한 게시물을 볼 수 있습니다</p>
      </div>
      <div class="board_list_wrap">
         <div class="board_list">
         <div class="top">
            <div class="num"style="width:20%;">게시판</div>
            <div class="title"style="width:70%;">글제목</div>
            <div class="count"style="width:10%;">삭제하기</div>
         </div>
         <c:if test="${count == 0}">
	         		스크랩한 목록이 없습니다.
	         	</c:if>
         	<c:if test="${count >0}">
         		<c:forEach var="scrap" items="${scrapList}">
         		<div>
		            <div class="num"style="width:20%;">
		            	<c:if test="${scrap.boardname=='com'}">
	  						커뮤니티
	  					</c:if> 
	  					<c:if test="${scrap.boardname=='diy'}">
	  						인테리어
	  					</c:if>
	  					<c:if test="${scrap.boardname=='infoboard'}">
	  						생활정보
	  					</c:if> 
	  					<c:if test="${scrap.boardname=='market'}">
	  						장터
	  					</c:if>
		            </div>
		            <div class="title" style="width:70%;">
			            <a href="/holo/contentFromScrap.holo?articlenum=${scrap.articlenum}&boardname=${scrap.boardname}">
							${scrap.subject} 
						</a>
		            </div>
		            <div class="count"style="width:10%;text-align:center;">
		            	<button class="btn-unScrap" articlenum="${scrap.articlenum}" boardname="${scrap.boardname}">❌</button>
		            </div>
		        </div>    
	            </c:forEach>
            </c:if>
         </div>

         <div>
         
        
         
         
         </div>    
                          
         </div>
         <div class="board_page">
           <c:set var="pageCount" value="${count / 20 + ( count % 20 == 0 ? 0 : 1)}"/>
		   <c:set var="pageBlock" value="${10}"/>
		   <fmt:parseNumber var="result" value="${pagenum / 10}" integerOnly="true" />
		   <c:set var="startPage" value="${result * 10 + 1}"/>
		   <c:set var="endPage" value="${startPage + pageBlock-1}"/>
		   <c:if test="${endPage > pageCount}">
		        <c:set var="endPage" value="${pageCount}"/>
		   </c:if> 
	          
		   <c:if test="${startPage > 10}">
		        <a class="button prev" href="/holo/member/scrapList.holo?pagenum=${startPage - 10 }">이전</a>
		   </c:if>
		
		   <c:forEach var="i" begin="${startPage}" end="${endPage}">
		   	   <c:if test="${pagenum==i}">
		   	   		<a class="num on" href="/holo/member/scrapList.holo?pagenum=${i}">${i}</a>
		   	   </c:if>
		   	   <c:if test="${pagenum!=i}">
		   	   		<a class="num on" href="/holo/member/scrapList.holo?pagenum=${i}">${i}</a>
		       </c:if>
		   </c:forEach>
		
		   <c:if test="${endPage < pageCount}">
		        <a class="button next" href="/holo/member/scrapList.holo?pagenum=${startPage + 10}">다음</a>
		   </c:if>
         </div>
         <div class="button_wrap">
            <a href="/holo/member/mypage.holo" class="on">뒤로가기</a>
         <br><br><br><br><br>
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>


</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>