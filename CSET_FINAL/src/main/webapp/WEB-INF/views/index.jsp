<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="./template/header.jsp">
	<jsp:param value="메인페이지" name="pageTitle"/>
</jsp:include>
<!-- Slider main container -->
<div class="main-banner">
	<div class="swiper-container">
	    <!-- Additional required wrapper -->
	    <div class="swiper-wrapper">
	        <!-- Slides -->
	        <div class="swiper-slide">
	        	<div>
		        	<img class="blind" alt="closet main banner" src="resources/assets/img/closet-banner.jpg"/>
					<h1 class="temp-logo">Welcome to Clothes-Set</h1>
	        	</div>
			</div>
	        <div class="swiper-slide">Slide 2</div>
	        <div class="swiper-slide">Slide 3</div>
	        <div class="swiper-slide">Slide 4</div>
	        <div class="swiper-slide">Slide 5</div>
	    </div>
	
	    <!-- If we need navigation buttons -->
	    <div class="fas fa-chevron-circle-left"></div>
	    <div class="fas fa-chevron-circle-right"></div>
	
<!-- 	    If we need scrollbar
	    <div class="swiper-scrollbar"></div> -->
	</div>
</div>
<h2 class="temp-phrase">Fill your closet with Clothes-Set, clothes that are set just for you</h2>


<c:if test="${loginDTO.mId == 'ADMIN'}">
	<div class="admin-box wrap">
		<h2>관리자 페이지</h2>
		${loginDTO.mName} 님 반갑습니다&nbsp;&nbsp;
		<ul class="admin-menu">
			<li><a href="memberListPage">회원관리</a></li>
			<li><a href="boardListPage">Q&A게시판 관리</a></li>
			<li><a href="boardListPage?bClass=0">공지사항 게시판</a></li>
			<li><a href="memberProductInsertPage">상품등록 페이지 이동하기</a>		
		</ul>
	</div>
</c:if>

<!-- TOP10(구매 수 기준?) 상품 리스트 -->
<c:if test="${loginDTO.mId ne 'ADMIN'}">
<div class="index wrap">
	<h1 class="page-title"><span class="eng-title">Top10 Popular Items</span></h1>
	<c:if test="${empty productsOrderByRank}">
	<div>
		상품없음
	</div>
	</c:if>
	<c:if test="${not empty productsOrderByRank }">
		<div class="products-box">
			<c:forEach var="pDTO" items="${productsOrderByRank }" varStatus="i">
			<div class="product-item">
				<a href="productsViewPage?pNo=${pDTO.pNo}">
					<span class="product-img medium" style="background-image: url('resources/product_photos/${pDTO.pFilename}')">
						<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">	
							<span class="isOnSale">Sale</span>
						</c:if>						
						<img class="blind" alt="${pDTO.pFilename}" src="${pageContext.request.contextPath}/resources/product_photos/${pDTO.pFilename}">
						<span class="rank-box">${i.count }</span>
						<img class="blind" alt="${pDTO.pFilename}" src="${pageContext.request.contextPath}/resources/product_photos/${pDTO.pFilename}">
					</span>
					<ul class="prod-info">
						<li>브랜드: ${pDTO.pBrand }</li>
						<li class="product-name">상품명: ${pDTO.pName }</li>
						<li>
							<!-- 할인 없을 경우 -->
							<c:if test="${pDTO.pDisrate eq null or pDTO.pDisrate eq 0}">
								<li class="product-price-small"><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,##0"/></li>
							</c:if>
							
							<!-- 할인될 경우 -->
							<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">					
								<span class="product-price-small">
									<span class="disrate">${pDTO.pDisrate }%</span>
									<fmt:formatNumber value="${pDTO.pPrice * (1 - (pDTO.pDisrate/100)) }" pattern="#,###" />
								</span>
								<del><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,###" /></del> 
							</c:if>
						</li>
						<li style="width: 110px;">
							<span style="position:relative; display: inline-block; margin-right: 10px; font-weight: bold;">평점: <fmt:formatNumber value="${pDTO.pRating}" pattern="0.00"/></span>
								<span style="position:relative; display: inline-block; width: 108px;">
									<span class="star_background" style="position:absolute; width:100%; overflow:hidden; color:#cdcdcd;">
										<i class="fas fa-star" style="color:#f1f1f1"></i>
										<i class="fas fa-star" style="color:#f1f1f1"></i>
										<i class="fas fa-star" style="color:#f1f1f1"></i>
										<i class="fas fa-star" style="color:#f1f1f1"></i>
										<i class="fas fa-star" style="color:#f1f1f1"></i>
	
									</span>
	
									<span class="star_fill" style="position:absolute; width:${pDTO.pRating / 5 *100}%; overflow:hidden; white-space:nowrap; color:blue;">
										<i class="fas fa-star" style="color:orange"></i>
										<i class="fas fa-star" style="color:orange"></i>
										<i class="fas fa-star" style="color:orange"></i>
										<i class="fas fa-star" style="color:orange"></i>
										<i class="fas fa-star" style="color:orange"></i>
								   </span>								   
							   </span>
						</li>
					</ul>
				</a>
			</div>				
			</c:forEach>
		</div>
	
	</c:if>
</div> 
</c:if>

<%@ include file="./template/footer.jsp" %>