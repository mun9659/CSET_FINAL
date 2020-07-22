<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="상품 상세 페이지" name="pageTitle"/>
</jsp:include>
<!-- 상품 상세 페이지(orders 와 reviews 연결및 수정보완 필요!!!) -->

<!-- 경민님 코드 -->

<script type="text/javascript">
   
function fn_cartInsert(f) {
	
	var pSize = f.pSize.value;
	console.log(pSize);
	var pAmount = f.pAmount.value;
	var loginDTO = '${loginDTO}';
	
	if( loginDTO != null && loginDTO != '' ) {
	   if ( pSize == null || pSize == '' ) {
	      alert('사이즈를 선택해주세요');
	      return false;
	   } else if( pAmount == null || pAmount == '' ){
	      alert('수량을 입력해주세요');
	   } else {	  
	     if(confirm('장바구니에 담겠습니까?')) {
	         f.action = 'cartInsert';
	         f.submit();
	      }		   
	   }		
	} else {
		alert('로그인 후에 장바구니를 이용하세요');
		location.href="memberLoginPage";
	}
}
   /* 바로 주문 수정 필요 */   
   function fn_pOrderQuickList(f) { // 현재 상품 뷰에 있는 f는 pNo, pSize, pAmount 를 가져간다.
	   var loginDTO = '${loginDTO}';
		
		if( loginDTO != null && loginDTO != '' ) {
	   
	      if ( f.pSize.value == null || f.pSize.value == '' ) {
	         alert('사이즈를 선택해주세요');
	         return false;
	      } else if( f.pAmount.value == null || f.pAmount.value == '' ){
	         alert('수량을 입력해주세요');
	         
	      } else{
	         if(confirm('바로 주문하시겠습니까?')) {
	            f.action = "pOrderQuick";
	            f.submit();
	         } else {
	            f.action = "productsViewPage";
	            f.submit();
	         }
	      }         
   		} else {
   			alert('로그인 후에 주문할 수 있습니다');
   			location.href= "memberLoginPage";
   		}
   }
   
    // 재고 비교
	$(document).ready( function(){
		// 가격 100원단위까지 절삭
		var disPrice = parseInt('${pDTO.pPrice * (1 - (pDTO.pDisrate/100)) }');
		disPrice = Math.round(disPrice/100)*100;
		$('#disPrice').text(disPrice.toLocaleString('en'));
		
		
	    //재고
	    $('#pAmount').change(function () {
	       $.ajax({
	          url: 'stockSelect',
	          type: 'get',
	          dataType: 'JSON',
	          data:'pSize='+ $( '#pSize option:selected' ).val() + '&pAmount=' + $('#pAmount').val() + '&pNo=' + $('#pNo').val(),
	          success: function(responseObject) {
	             if ( responseObject.result == 'NOSTOCK' ) {           
	             alert('재고가 없습니다.');
	             }
	             
	          },
	          error: function(){
	             alert("ajax통신실패");
	          }
	       
	       });
	          
	    });   
	    
	 }); 
</script>



<div class="product-view wrap">

	<div class="product-view-box">
		<div class="product-img large" style="background-image: url('resources/product_photos/${pDTO.pFilename }')">
			<img class="blind" alt="${pDTO.pName }" src="resources/product_photos/${pDTO.pFilename }"/>
		</div>
		<form class="product-info">
			<ul>
				<li class="page-title">${pDTO.pName }</li>
				<li>브랜드: ${pDTO.pBrand }</li>
				<li>
					<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">
						<div class="product-price disrate">${pDTO.pDisrate }%</div>
					</c:if>
					<c:if test="${pDTO.pDisrate eq null or pDTO.pDisrate eq 0}">
						<span class="product-price"><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,##0"/></span>
					</c:if>
					<c:if test="${pDTO.pDisrate ne null and pDTO.pDisrate ne 0}">
						
						<del class="product-price"><fmt:formatNumber value="${pDTO.pPrice }" pattern="#,###" /></del> 
						<i class="fas fa-arrow-right"></i>
						<span class="dis-price product-price" id="disPrice">
							<fmt:formatNumber value="${pDTO.pPrice * (1 - (pDTO.pDisrate/100)) }" pattern="#,###" />
						</span>
					</c:if>
				</li>
				<li class="member-point">
					적립 포인트 &nbsp;&nbsp;:&nbsp;&nbsp;
					<span class="member-point bold"><fmt:formatNumber value="${pDTO.pPrice * 0.02 }" pattern="#,###"/>P</span>
				</li>
				<li>
					<select id="pSize" name="pSize">
						<option value="">[사이즈]를 선택하세요.</option>
						<c:forEach var="sDTO" items="${stockList }">
							<c:choose>
								<c:when test="${sDTO.pSize eq 'S' }">
									<option value="S">S [재고 : ${sDTO.sAmount }]</option>								
								</c:when>
								<c:when test="${sDTO.pSize eq 'M' }">
									<option value="M">M [재고 : ${sDTO.sAmount }]</option>								
								</c:when>
								<c:otherwise>
									<option value="L">L [재고 : ${sDTO.sAmount }]</option>								
								</c:otherwise>
							</c:choose>						
						</c:forEach>
					</select>
				</li>
				<li>
					<label>수량 &nbsp;&nbsp;&nbsp;&nbsp; <input type="number" name="pAmount" min="1" max="100" id="pAmount"/>
						<input type="hidden" id="pNo" name="pNo" value="${pDTO.pNo}"/>
					</label>
				</li>
				<li class="btn-box">
					<input type="hidden" name="pPrice" value="${pDTO.pPrice * (1 - (pDTO.pDisrate/100)) }" />
					<input type="hidden" name="pNo" value="${pDTO.pNo }"/>
					<input class="prod-view-btn" type="button" value="장바구니에 넣기" onclick="fn_cartInsert(this.form)" /> <!--onclick="fn_cartInsert(this.form)"/>  -->
					<script type="text/javascript">
						$(function(){
							$('#pAmount').change(function(){
								// console.log($('#pSize').val());
								var a = $('#pSize').val();
								console.log($('#' + a + 'Stock').text());
							});
						});
					</script>
					<input class="prod-view-btn" type="button" value="바로구매" onclick="fn_pOrderQuickList(this.form)"/>
					<input class="prod-view-btn" type="button" value="뒤로가기" onclick="location.href='productsListPage'"/>
				</li>
			</ul>
		</form>
	</div>

		<!-- 리뷰 리스트 -->
		
		<div class="product-review wrap">
			<form>
			<c:if test="${empty rList }">
				<h2 class="page-subtitle">가장 먼저 리뷰를 작성해 보세요.</h2>
			</c:if>
			<h3 class="reviews-count">전체 : ${totalRecord}개 리뷰</h3>
				<c:if test="${not empty rList }" >
				<h2 class="page-subtitle" style="font-family: 'Galada', cursive">Photo Reviews</h2>
				<table>
					<c:forEach var="rDTO" items="${rList}">
						<!-- 사진 파일이 있을 때 -->
						<c:if test="${not empty rDTO.rFilename }">
							<tr>
								<td>
									<ul>
										<li>
											<span class="review-writer">${rDTO.mId}<br/>${rDTO.rRegdate }</span>
											<div class="review-stars">
												<c:forEach begin="1" end="${rDTO.rRating }" step="1">
													<i class="fas fa-star fa-2x"></i>
												</c:forEach>
												<c:forEach begin="1" end="${5-rDTO.rRating }" step="1">
													<i class="far fa-star fa-2x"></i> 
												</c:forEach>
											</div>
											<div class="product-img review" style="background-image: url('resources/reviewsStorage/${rDTO.rFilename}')">
												<img class="blind" alt="${rDTO.rFilename }" src="${pageContext.request.contextPath}/resources/reviewsStorage/${rDTO.rFilename}"><br/>
											</div>
										</li>
										<li>
											<div class="review-contents">
												<span>${rDTO.rContent.length() > 200 ? rDTO.rContent.substring(0, 200).concat('...') : rDTO.rContent}</span>
												<a href="reviewsViewPage?rNo=${rDTO.rNo}">더보기</a>
												<input type="hidden" name="page" value="${page }" />
												<input type="hidden" name="pNo" value="${rDTO.pNo }" />
											</div>
										</li>
									</ul>						
								</td>							
							</tr>			
						</c:if>
						</c:forEach>
					</table>
					<h2 class="page-subtitle" style="font-family: 'Galada', cursive">Text Reviews</h2>
					<table>
						<c:forEach var="rDTO" items="${rList}">
							<!-- 사진 파일이 없을 때 -->
							<c:if test="${empty rDTO.rFilename }">						
								<tr>
									<td>
										<ul>
											<li>
												<span class="review-writer">${rDTO.mId}<br/>${rDTO.rRegdate }</span>
												<div class="review-stars">
													<c:forEach begin="1" end="${rDTO.rRating }" step="1">
														<i class="fas fa-star fa-2x"></i>
													</c:forEach>
													<c:forEach begin="1" end="${5-rDTO.rRating }" step="1">
														<i class="far fa-star fa-2x"></i> 
													</c:forEach>
												</div>				
											</li>
											<li>
												<div class="review-contents">
													<span>${rDTO.rContent.length() > 200 ? rDTO.rContent.substring(0, 200).concat('...') : rDTO.rContent}</span>
													<a href="reviewsViewPage?rNo=${rDTO.rNo}">더보기</a>
													<input type="hidden" name="page" value="${page }" />
													<input type="hidden" name="pNo" value="${rDTO.pNo }"/>													
												</div>
											</li>
										</ul>						
									</td>							
								</tr>			
							</c:if>					
						</c:forEach>
						<tr>
							<td class="centered">${reviewPageView}</td>
						</tr>				
					</table>
					</c:if>
					
			
			</form>
	</div>
	
</div>
	
<br/>
<%@ include file="../template/footer.jsp" %>
