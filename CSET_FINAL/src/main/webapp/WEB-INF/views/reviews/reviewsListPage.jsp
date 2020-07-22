<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="리뷰 목록" name="pageTitle"/>
</jsp:include>
<!-- rFilename -->
<link rel="stylesheet" type="text/css" href="resources/assets/style/style.css" />
<!-- rRating -->

	<div class="wrap">
		<h3>전체 : ${totalRecord}개 리뷰</h3>
		<c:if test="${empty rList }">
			가장 먼저 리뷰를 작성해 보세요.<br/>
		</c:if>
		<c:if test="${not empty rList }" >
		
			<h5>포토 리뷰</h5>
			<c:forEach var="rDTO" items="${rList}">
				<!-- 사진 파일이 있을 때 -->
				<c:if test="${not empty rDTO.rFilename }">
					
					<div class="photo_reviews">
					No.${rDTO.rNo}<br/>
					ID ${rDTO.mId}<br/>
					<!-- rContent 글자 자르기  -->
					${rDTO.rContent.length() > 50 ? rDTO.rContent.substring(0, 50) : rDTO.rContent}<br/>
					<img class="product-img-small" alt="${rDTO.rFilename }" src="${pageContext.request.contextPath}/resources/reviewsStorage/${rDTO.rFilename}"><br/><c:forEach begin="1" end="${rDTO.rRating }" step="1">
						<i class="fas fa-star fa-2x"></i>
					</c:forEach>
					<c:forEach begin="1" end="${5-rDTO.rRating }" step="1">
						<i class="far fa-star fa-2x"></i> 
					</c:forEach><br/>
					${rDTO.rRegdate }<br/>
					<a href="reviewsViewPage?rNo=${rDTO.rNo}">더보기</a>
					
					</div>
					<br/><br/>
				</c:if>
			</c:forEach>
			
			
			<h5>텍스트 리뷰</h5>
			<c:forEach var="rDTO" items="${rList}">
				<!-- 사진 파일이 없을 때 -->
				<c:if test="${empty rDTO.rFilename }">
					
					<div class="text_reviews">
						
						Review No.${rDTO.rNo}<br/>
						ID ${rDTO.mId }<br/>
						${rDTO.rContent }<br/>
						
						<img class="product-img-small" alt="${rDTO.rFilename }" src="${pageContext.request.contextPath}/resources/reviewsStorage/${rDTO.rFilename}"><br/>
						
						<!-- 별점 view -->
						<c:forEach begin="1" end="${rDTO.rRating }" step="1">
		 					<i class="fas fa-star fa-2x"></i>
		 				</c:forEach>
		 				<c:forEach begin="1" end="${5-rDTO.rRating }" step="1">
		 					<i class="far fa-star fa-2x"></i> 
		 				</c:forEach><br/>
						${rDTO.rRegdate }<br/>
						<a href="reviewsViewPage?rNo=${rDTO.rNo}">더보기</a>
					</div>
					<br/><br/>
				</c:if>
			</c:forEach>
		</c:if>
		<input type="hidden" name="pNo" value="${rDTO.pNo }" />
		${reviewPageView } <!-- reviews페이지 -->
		<input type="button" value="뒤로 가기" onclick="history.back()" />
	</div>


<%@ include file="../template/footer.jsp" %>