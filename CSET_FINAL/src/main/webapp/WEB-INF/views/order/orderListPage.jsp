<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="페이지 제목" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">
	
	/* 함수 ↓↓↓↓↓ */
	(function(){	
		var loginDTO = '${loginDTO}';
		if (loginDTO == null || loginDTO == '') {
			alert('로그인 후 사용하실수 있습니다.');
			location.href='memberLoginPage';
		} else {
			return;
		}
	})();
	
	function fn_cancle() {
		if(confirm('구매를 취소하시겠습니까?')) {		
			location.href='productsListPage';
		}
	}
	
	var doubleClickFlag = false;
	function doubleClickCheck() {
		if(doubleClickFlag) {
			return doubleClickFlag;
		} else {
			doubleClickFlag = true;
			return false;
		}
	}
	
	function fn_usemPoint() { // ${loginDTO.mPoint} 값과 비교해서 사용 가능한지 안하는지 부터 확인
		var mPoint = parseInt('${loginDTO.mPoint}');
		var usemPoint = parseInt($('#usemPoint').val());
		var finalPrice = parseInt($('#final_price').text());
		if ( mPoint < usemPoint ){
			alert('가지고 계신 포인트보다 높은 값입니다.');
		} else {	
			if (doubleClickCheck()) { return; }
			$('#currPoint').text( mPoint - usemPoint);
			$("#final_price").text(finalPrice - usemPoint);
		}
	}
	
	function fn_orderInsert(f) {
		if ( $('#receiver').val() == '' ){
			alert("수령인을 입력하세요");
			return;
		}
		if ( $('#rPhone').val() == '' ){
			alert("수령인 연락처를 입력하세요");
			return;
		}
		if ( $('#rAddr').val() == '' ){
			alert("배송 주소를 입력하세요");
			return;
		}
		if ($("#selectNote").val() == 0) {
			alert('배송 메모를 선택하세요');
			return;
		}
		f.action = 'orderInsert';
		f.submit();
	}
	
	// 총 구매금액을 담기 위한 변수 선언
	var total_price = 0;	  // 할인 전 금액
	var dis_total_price = 0;  // 할인 후 금액
	var total_discounted = 0; // 할인된 총 금액
	
	
	// 회원 등급에 따른 할인율 적용
	var mGrade = '${loginDTO.mGrade}';
	var disrate = 0;
	
	switch(mGrade) {
	case 'A': disrate = 0.15; break;
	case 'B': disrate = 0.1; break;
	case 'C': disrate = 0.05; break;
	case 'D': disrate = 0; break;
	default: disrate = 0; break;
	}
	
	
</script>
<div class="order-list wrap">
	<h1 class="page-title">주문 페이지</h1>
		<form id="orderResult" method="POST">
			<div class="orderList"> <!-- 주문상품 정보 -->
				<table>
					<thead>
						<tr>
							<th colspan="2">주문할 상품</th> <!-- pBrand 갖고오기 -->
							<th>수량</th>
							<th>회원등급 할인</th>
							<th>주문금액</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty cjList }">
							<tr>
								<td colspan="4">주문 내용 없음</td>
							</tr>	
						</c:if>
						<c:if test="${not empty cjList }">
							<c:forEach var="cJVO" items="${cjList }" varStatus="status">
								<tr>
									<td>
										<div class="product-img small" style="background-image: url('resources/product_photos/${cJVO.pFilename}')">
											<img class="blind" src="resources/product_photos/${cJVO.pFilename}" alt="제품 이미지" />
										</div>
									</td>
									<td>
										<ul class="order-prod-info">
											<li>
												<a class="bold" href="productsViewPage?pNo=${cJVO.pNo }">${cJVO.pName }</a>
											</li>										
											<li class="prod-brand">${cJVO.pBrand }</li>
											<li>
												사이즈 : ${cJVO.cSize }
												<input type="hidden" name="oSize" value="${cJVO.cSize }"/>
												<input type="hidden" name="oAmount" value="${cJVO.cAmount }"/>
												<input type="hidden" name="pNo" value="${cJVO.pNo }" />
											</li>	
										</ul>
									</td>
									<td>
										${cJVO.cAmount }
									</td>
									<td class="mGrade">	
										<ul>
											<li class="mb10">회원등급 : <span class="mGrade">${loginDTO.mGrade }</span></li>
											<li><span id="disrate${status.index }"></span> %</li>
										</ul>												
									</td>
									<td class="oPrice">
										<span id="oPrice${status.index }"><del></del></span>
										<span class="productTotalPrice" id="disoPrice${status.index }"></span>
										<input type="hidden" name="oPrice"/>
									</td>
								</tr>
								<script type="text/javascript">
								
									$(document).ready(function(){
										var i = '${status.index }';	
										
										// 할인 전 가격
										// 수정 1. 이전 가격(원래 상품가격 * 상품 수량 * 상품 자체적인 할인율) pDisrate 관련 추가
										// 수정 1-1. 절삭 추가
										var beforeoPrice = parseInt('${cJVO.pPrice * cJVO.cAmount * (1-(cJVO.pDisrate/100))}');
										beforeoPrice = Math.round( beforeoPrice / 100 ) * 100;
										$('#oPrice'+i + ' > del').text(beforeoPrice.toLocaleString('en'));	
										// 할인 전 가격 총합
										total_price += beforeoPrice;
										// 이거를 결과 박스 맨 처음에 보여줌
										$('#total_price + span').text(total_price.toLocaleString('en'));																			
										
										// 할인율
										$('#disrate'+i).text(disrate*100);
										
										// 할인 가격
										var discounted =  Math.round( (beforeoPrice * disrate) / 100) * 100;
										// 총 할인 가격
										total_discounted += discounted;
										$('#discounted').text(total_discounted.toLocaleString('en'));
						
										// 할인된 가격
										var afteroPrice = Math.round( (beforeoPrice-discounted) / 100 ) * 100;
										// 할인된 가격의 총합
										dis_total_price += afteroPrice;
										// 할인된 가격 총합은 DB에 넘어가서 회원 구매실적에 등록됨
										$('#total_price').val(dis_total_price.toLocaleString('en'));																			
																		
										$('#disoPrice'+i).text(afteroPrice.toLocaleString('en'));										
										$('#disoPrice'+i + ' + input[type="hidden"]').val(afteroPrice);										
										
										// 배송비 책정의 기준은 할인된 총 가격
										if(parseInt( dis_total_price ) >= 100000) {
											$('#fee').text(0); 
										} else {
											$('#fee').text(3000);
										}
										
										// 배송포함, 포인트 차감한 마지막 가격
									
										var final_price = dis_total_price + Number($('#fee').val());
										$('#final_price').text(final_price);
										
		
										
										/* 메모 직접 입력시에만 나타나게 하는 함수 */
										$("#selectNoteDirect").hide();
										$("#selectNote").change(function(){
											// 직접입력 누를 때만 나타남
											if($("#selectNote").val() == "5") {
												$("#selectNoteDirect").show();
											} else {
												$("#selectNoteDirect").hide();
											}
										});
										
									});
								</script>
							</c:forEach>
						</c:if>
					</tbody>					
				</table>
				
				<table class="result-box">
					<tr>
						<td>총 상품 금액</td>
						<td></td>
						<td>총 배송비</td>
						<td></td>
						<td>회원 등급 할인</td>
						<td>포인트</td>
						<td>최종 결제 금액</td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="total_price" id="total_price" readonly="readonly"/>
							<span></span>
						</td>
						<td><span class="operator"> + </span></td>
						<td><span id="fee"></span></td>
						<td><span class="operator"> - </span></td>
						<td><span id="discounted"></span></td>						
						<td>
							<ul class="use-point">
								<li>현재 보유 포인트: <span id="currPoint">${loginDTO.mPoint }</span></li>
								<li>포인트 사용 : <input type="text" name="usemPoint" id="usemPoint" value="0"/> POINT</li>
								<li><input type="button" value="적용하기" onclick="fn_usemPoint()"/></li>
							</ul>							
						</td>
						<td><span id="final_price"></span></td>
					</tr>
				</table>				
			</div>
			<h2 class="page-subtitle">배송정보</h2>
			<table class="memberReceiveInfo">
			
				<tr><td colspan="2"><h3 class="order-info">주문자 정보</h3></td>
				<tr>
					<td>이름</td>
					<td><input type="text" value="${loginDTO.mName}" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" value="${loginDTO.mPhone}" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" value="${loginDTO.mEmail}" readonly="readonly"/></td>
				</tr>		
				<tr><td colspan="2"><h3 class="order-info">배송지 정보</h3></td>
				<tr>
					<td>수령인</td>
					<td><input type="text" id="receiver" name="receiver" /></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td>
						<input type="text" id="rPhone"  name="rPhone" />
					 </td>
				</tr>
				<tr>
					<td>배송주소</td>
					<td><input type="text" id="rAddr" name="rAddr" /></td>
				</tr>
				<tr>
					<td>배송메모</td>
					<td>
						<select id="selectNote" name="selectNote">
							<option value="0">배송시 요청사항을 선택해주세요</option>
							<option value="1">부재시 경비(관리)실에 맡겨주세요</option>
							<option value="2">부재시 문앞에 놓아주세요</option>
							<option value="3">직접 받겠습니다</option>
							<option value="4">배송전에 연락해주세요</option>
							<option value="5">직접 입력</option>
						</select>
						<input type="text" id="selectNoteDirect" name="selectNoteDirect"/>
					</td>
				</tr>				
			</table>
			
			<div class="btn-box">
				<input type="button" value="결제하기" onclick="fn_orderInsert(this.form)"/>&nbsp;
				<input type="button" value="취소하기" onclick="fn_cancle()" />
			</div>
		</form>
</div>

<%@ include file="../template/footer.jsp" %>