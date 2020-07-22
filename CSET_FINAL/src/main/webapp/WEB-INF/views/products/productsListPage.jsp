<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="상품 리스트 페이지" name="pageTitle"/>
</jsp:include>
<div class="products-list wrap">
	<!-- 상품 및 카테고리로 검색하기 -->
		<div class="product-query-ckbox">
			<form action="productsOrderByDynamic">				
				<table>
					<tr>
						<td colspan="2">
							<label>상품검색&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="searchBox" /></label>
						</td>
					</tr>
					<tr>
						<td class="chkbox-title">대분류</td>
						<td class="category">
							<label><input type="checkbox" name="pCategoryList" value="상의"/>상의</label>
							<label><input type="checkbox" name="pCategoryList" value="하의"/>하의</label>
							<label><input type="checkbox" name="pCategoryList" value="아우터"/>아우터</label>							
						</td>
					</tr>
					<tr>
						<td class="chkbox-title">소분류</td>
						<td class="sub-category">
							<label><input type="checkbox" name="pCategory_subList" value="티셔츠"/>티셔츠</label>
							<label><input type="checkbox" name="pCategory_subList" value="맨투맨후드"/>후드/맨투맨</label>
							<label><input type="checkbox" name="pCategory_subList" value="셔츠/남방"/>셔츠/남방</label>
							<label><input type="checkbox" name="pCategory_subList" value="청바지"/>청바지</label>
							<label><input type="checkbox" name="pCategory_subList" value="슬랙스"/>슬랙스</label>
							<label><input type="checkbox" name="pCategory_subList" value="면바지"/>면바지</label>
							<label><input type="checkbox" name="pCategory_subList" value="반바지"/>반바지</label>						
							<label><input type="checkbox" name="pCategory_subList" value="자켓"/>자켓</label>
							<label><input type="checkbox" name="pCategory_subList" value="코트"/>코트</label>					
							<label><input type="checkbox" name="pCategory_subList" value="롱패딩"/>롱패딩</label>					
							<label><input type="checkbox" name="pCategory_subList" value="숏패딩"/>숏패딩</label>					
						</td>
					</tr>
					<tr>
						<td class="chkbox-title">브랜드</td>
						<td>					
							<label><input type="checkbox" name="pBrandList" value="나이키"/>나이키</label>
							<label><input type="checkbox" name="pBrandList" value="아디다스"/>아디다스</label>
							<label><input type="checkbox" name="pBrandList" value="페이탈리즘"/>페이탈리즘</label>
							<label><input type="checkbox" name="pBrandList" value="무신사스탠다드"/>무신사 스탠다드</label>
							<label><input type="checkbox" name="pBrandList" value="세븐셀라"/>세븐셀라</label>
							<label><input type="checkbox" name="pBrandList" value="피스워커"/>피스워커</label>
							<label><input type="checkbox" name="pBrandList" value="인사일런스"/>인사일런스</label>
						</td>					
					</tr>
					<tr>
						<td colspan="2">
							<select name="searchOrderBy">
								<option value="pNoDesc">최신순</option>
								<option value="pPriceDesc">높은가격순</option>
								<option value="pPriceAsc">낮은가격순</option>
								<option value="pRatingDesc">평점순</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="검색" />	
						</td>
					</tr>
				</table>						
			</form>
		</div>
	<!-- 상품 나열 및 링크 -->
		<c:if test="${empty productsList}">
		<div class="notice">
			상품없음
		</div>
		</c:if>
		<c:if test="${not empty productsList }">
			<div class="products-box">
				<c:forEach var="pDTO" items="${productsList }" varStatus="i">
					<div class="product-item">
					<a href="productsViewPage?pNo=${pDTO.pNo}">
						<span class="product-img medium" style="background-image: url('resources/product_photos/${pDTO.pFilename}')">
							<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">	
								<span class="isOnSale">Sale</span>
							</c:if>						
							<img class="blind" alt="${pDTO.pFilename}" src="${pageContext.request.contextPath}/resources/product_photos/${pDTO.pFilename}">
						</span>
						<ul class="prod-info">
							<li>${pDTO.pBrand }</li>
							<li class="product-name">${pDTO.pName }</li>
							<li>
								<!-- 할인 없을 경우 -->
								<c:if test="${pDTO.pDisrate eq null or pDTO.pDisrate eq 0}">
									<li class="product-price-small"><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,##0"/></li>
								</c:if>
								
								<!-- 할인될 경우 -->
								<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">					
									<span class="product-price-small">
										<span class="disrate">${pDTO.pDisrate }%</span>
										
										<script type="text/javascript">
											$( function() {
												var i ='${i.index}';
												var disPrice = parseInt('${pDTO.pPrice * (1 - (pDTO.pDisrate/100)) }');
												disPrice = Math.round(disPrice/100)*100;
												
												$('#disPrice'+i).text( disPrice.toLocaleString('en') );
											});
											
										</script>
										
										<span class="bold" id="disPrice${i.index }"></span>
									</span>
									<del><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,###" /></del> 
								</c:if>
							</li>
							<li style="width:110px">
								<span style="position:relative; display: inline-block; margin-right: 10px;">평점: <fmt:formatNumber value="${pDTO.pRating}" pattern="0.00"/></span>
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
<%@ include file="../template/footer.jsp" %>
