<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<jsp:include page="../template/header.jsp">
	<jsp:param value="리뷰 조회" name="pageTitle"/>
</jsp:include>


<div class="review-view wrap" >
	<h1 class="page-title">${rDTO.mId }님의 리뷰입니다</h1>
	<form method="POST">
		<table>
			<tr>
				<td class="review-stars">
					<c:forEach begin="1" end="${rDTO.rRating }" step="1">
						<i class="fas fa-star fa-2x"></i>
					</c:forEach>
					<c:forEach begin="1" end="${5-rDTO.rRating }" step="1">
						<i class="far fa-star fa-2x"></i> 
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td>
					<div class="review-content">${rDTO.rContent }</div>
						<c:if test="${rDTO.rFilename ne null and rDTO.rFilename ne ''}">
							<div class="product-img large" style="background-image: url('${pageContext.request.contextPath}/resources/reviewsStorage/${rDTO.rFilename}')">
								<img class="blind" alt="${rDTO.rFilename }" src="${pageContext.request.contextPath}/resources/reviewsStorage/${rDTO.rFilename}" />
							</div>		
						</c:if>
					<div class="bold">${rDTO.rRegdate }</div>
						<input type="hidden" name="rRating" value="${rDTO.rRating }" />
						<input type="hidden" name="rNo" value="${rDTO.rNo }"/>
						<input type="hidden" name="pNo" value="${rDTO.pNo }"/>
				</td>
			</tr>
			<tr>
				<td class="btn-box">
					<!-- 로그인한 아이디와 동일하면 수정,삭제 버튼 생성 -->
					<c:if test="${loginDTO.mId eq rDTO.mId }">
					<input type="button" value="수정" onclick="location.href='goReviewsUpdatePage?rNo=${rDTO.rNo}'"><!-- 이 버튼은 수정페이지로 이동하는 버튼 -->
					<input type="button" value="삭제" onclick="fn_reviewsDelete(this.form)" />
					</c:if>
					<input type="button" value="전체 목록" onclick="fn_reviewsList(this.form)" /> 
				</td>
			</tr>
		</table>
		
	
	</form>

	
	
</div>	

<%@ include file="../template/footer.jsp" %>