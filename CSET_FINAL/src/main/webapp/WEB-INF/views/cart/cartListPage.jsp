<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="장바구니" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	
	(function(){	
		var loginDTO = '${loginDTO}';
		if (loginDTO == null || loginDTO == '') {
			alert('로그인 후 사용하실수 있습니다.');
			location.href='memberLoginPage';
		} else {
			return;
		}
	})();
	
	/* 전체 체크박스 선택 */
	$("#chk_all").click(function(){
		 var chk_all = $("#chk_all").prop("checked");
		 if(chk_all) {								
			$(".chk").prop("checked", true);
		 } else {
		 	$(".chk").prop("checked", false);
		 }
	});
	
	// 선택된 카트 값(카트 번호)을 삭제
	$(".selectDelete_btn").click(function(){
		
		if ($("input:checkbox[id='chk']").is(":checked") == false) {
			alert('선택한 물품이 없습니다.');
		} else {
			
		 	var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		 	if(confirm_val) {
		 		
		  		var checkArr = new Array();
		   
			   	$("input[class='chk']:checked").each(function(){
			    	checkArr.push($(this).val());
			   	});
		    	
			   	$.ajax({
				    url : "cartDeleteSelect",
				    type : "POST",
				    data : { chk : checkArr },
				    success : function(){
				    	alert('정상적으로 삭제되었습니다.');
				    	location.href = "cartListPage";
			    	},
			    	error : function() {
			    		alert('ajax 에러');
			    		location.href = "cartListPage";
			    	}
			   });
		  	} 
		}
	});
	
	$("#orderListPage_btn").click(function(){
		if ($("input:checkbox[id='chk']").is(":checked") == false) {
			alert('선택한 물품이 없습니다.');
		} else {
			if (confirm('주문하시겠습니까?')) {
				
				$('#f').attr('action', 'orderListPage');
				$('#f').submit();
				
			}
		}
	});

});

/* 		함수 ↓↓↓ 	*/

// 취소하면 카트에 들어있는 DB(cart) 전부 삭제
function fn_cancle(f) {
	if (confirm('취소하시겠습니까?')) {
		f.action = 'cartAllDelete';
		f.submit();
	}
}

</script>
	<div class="cart wrap">
		<h2 class="page-title">클로젯 배송 상품</h2>
		<c:choose>
			<c:when test="${empty list }">
	        	<div class="notice">장바구니가 비었습니다.</div>
	    	</c:when>
			<c:otherwise>
				<form id="f">
					<div class="checkDelete">
						<label class="chk_all"><input type="checkbox" id="chk_all" /> 전체 선택</label>
						<input type="button" class="selectDelete_btn" value="선택 항목 삭제" />
					</div>
			
					<div class="cartList">
						<table>
							<thead>
								<tr>
									<th colspan="3">상품</th>
									<th>수량</th>
									<th>주문금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cDTO" items="${list }" varStatus="status">
									<!-- 수량 변경 -->
										<tr>
											<td>
												<input type="checkbox" id="chk" class="chk" name="chk" value="${cDTO.cNo }"/> <!-- 선택 박스 하나라도 미클릭시 전체선택 체크박스 해제 -->
											</td>
											<td>
												<div class="product-img small" style="background-image: url('resources/product_photos/${cDTO.pFilename}')">
													<img class="blind" src="resources/product_photos/${cDTO.pFilename}" alt="제품 이미지">
												</div>
											</td>
											<td>
												<ul class="order-prod-info">
													<li>${cDTO.pName }</li>
													<li>사이즈 : ${cDTO.cSize }</li>
												</ul>												
												<input type="hidden" name="cSize" value="${cDTO.cSize }" />
											</td>
											<td>
												<div class="cAmount-box">
													<button  id="minusBtn${cDTO.cNo }" class="cAmountBtn" type="button"><i class="fas fa-minus-circle"></i></button>
													<input class="cAmount" type="text" id="cAmount${cDTO.cNo }" name="cAmount" value="${cDTO.cAmount}" readonly="readonly"> 
													<button  id="plusBtn${cDTO.cNo }" class="cAmountBtn" type="button"><i class="fas fa-plus-circle"></i></button>
												</div>												
											</td>
											<td>
												 <!-- 상품 가격 * 수량 -->
												 <!-- 수정1. 상품 전체 가격 format 추가, pDisrate 값 추가 -->
												<span class="productTotalPrice" id="cPrice${cDTO.cNo }"></span>
												<input type="hidden" name="cNo" value="${cDTO.cNo }" /> <!-- 바로 주문용 장바구니 번호 -->
												 <!-- 수정2. 상품 가격 pDisrate 값 추가 -->
												<input type="hidden" id="pPrice${cDTO.cNo }" name="pPrice" value="${cDTO.pPrice * (1-(cDTO.pDisrate/100)) }" /> <!-- 상품 가격(할인율 적용) -->
												<input type="button" value="바로주문" onclick="location.href='cOrderQuick?cNo=${cDTO.cNo}'" /> <!-- 바로 주문 버튼 -->
											</td>
										</tr>
										<script type="text/javascript">
											$(document).ready(function(){
												var i = '${cDTO.cNo }';
												var productPrice = parseInt('${cDTO.productPrice }'); // 각 상품에 할인율 적용된 가격
												$('#cPrice'+i).text(parseInt(productPrice * $('#cAmount'+i).val()));

												// 전체선택 해제여부
												$("#chk").click(function() {
													if($("input[name='chk']:checked").length == ${status.index + 1}){
														$("#chk_all").prop("checked", true);
													} else {
														$("#chk_all").prop("checked", false);
													}
												});
												
												$('#plusBtn'+i).click( function(){
													if($('#cAmount'+i).val() >= 30) {
														alert('1보다 작고 30보다 큰 수는 넣을수 없습니다.');
														return;
													}
													
													$.ajax({
														url: 'cartPlusCalc'
														, type: "get"
														, dataType: "JSON"
														, data: { 
															cAmount : $('#cAmount'+i).val()
															, cNo : '${cDTO.cNo}'
															}
														, success: function( responseObj ) {
												
															var sum = parseInt($('#sumMoney').text());		

															$('#cAmount'+i).val(responseObj.result);  // 상품 수량 변경
															
															var productTotalPrice = parseInt( $('#cAmount'+i).val() * productPrice );
																														
															$('#cPrice'+i).text(productTotalPrice);  // 각 상품 총 가격 변경
															sum += productPrice;													
															$('#sumMoney').text(sum); // 총 상품 가격 합산
															if(parseInt($('#sumMoney').text()) >= 100000) {
																$('#fee').text(0); // 총 상품 가격에 따른 배송비 분리
																$('#fee + input[type="hidden"]').val(0);
															} else {
																$('#fee').text(3000);
																$('#fee + input[type="hidden"]').val(3000);
															}
															
															var total_price = parseInt($('#sumMoney').text()) + parseInt($('#fee').text());	
																												
															$('#total_price').val(total_price); // 결과 값 */
															$('#total_price + span').text(total_price); // 결과 값 */
														}
													});
												});	
												
												$('#minusBtn'+i).click( function(){
													if($('#cAmount'+i).val() <= 1) {
														alert('1보다 작고 30보다 큰 수는 넣을수 없습니다.');
														return;
													}
													$.ajax({
														url: 'cartMinusCalc'
														, type: "get"
														, dataType: "JSON"
														, data: { 
															cAmount : $('#cAmount'+i).val()
															, cNo : '${cDTO.cNo}'
															}
														, success: function( responseObj ) {
															
															var sum = parseInt($('#sumMoney').text());
															
															$('#cAmount'+i).val(responseObj.result);  // 상품 수량 변경
															
															var productTotalPrice = parseInt( $('#cAmount'+i).val() * productPrice );
															
															$('#cPrice'+i).text(productTotalPrice);  // 각 상품 총 가격 변경
															sum -= parseInt(productPrice);
															$('#sumMoney').text(sum); // 총 상품 가격 합산
															if(parseInt($('#sumMoney').text()) >= 100000) {
																$('#fee').text(0); // 총 상품 가격에 따른 배송비 분리
																$('#fee + input[type="hidden"]').val(0);
															} else {
																$('#fee').text(3000);
																$('#fee + input[type="hidden"]').val(3000);
															}
															
															
															var total_price = parseInt($('#sumMoney').text()) + parseInt($('#fee').text());
																													
															$('#total_price').val(total_price); // 결과 값 */
															$('#total_price + span').text(total_price); // 결과 값 */
														}
													});
												});
											});
											
										</script>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 현재 카트에 담긴 모든 것 -->
					<!--  -->
					<table class="result-box">
						<tr>
							<td>총 상품금액</td>
							<td></td>
							<td>배송비</td>
							<td></td>
							<td>총 결제예상 금액</td>
						</tr>
						<tr>
							<td><span class="bold" id="sumMoney">${sumMoney }</span></td>
							<td><span class="operator"> + </span></td>
							<td>
								<span class="bold" id="fee">${fee }</span>
								<input type="hidden" name="fee" value="${fee }"/>
							</td>
							<td><span class="operator"> = </span></td>
							<td>
								<input type="hidden" name="total_price"  id="total_price" value="${total }" readonly="readonly"/>
								<span>${total }</span>원
							</td>
						</tr>
					</table>
					<div class="btn-box">
						<input type="button" id="orderListPage_btn" value="주문하기" />&nbsp;&nbsp;
						<input type="button" value="취소하기" onclick="fn_cancle(this.form)" />
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
<%@ include file="../template/footer.jsp" %>