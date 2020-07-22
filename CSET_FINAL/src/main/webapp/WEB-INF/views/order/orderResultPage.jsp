<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="주문 완료" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		var mPoint  = '${mPoint}';
		var addmPoint = '${total_price * 0.02}';
		var usemPoint = '${usemPoint}';
		
		$('#mPoint').text(mPoint);
		if (parseInt(usemPoint) == 0) {
			addmPoint = Math.round(addmPoint / 10) * 10;
			resultmPoint = Number(mPoint) + Number(addmPoint);
			$('#addmPoint').text(addmPoint);
			$('#resultmPoint').text(resultmPoint);
			
		} else {
			resultmPoint = Number(mPoint) - Number(usemPoint);
			$('#usemPoint').text(usemPoint);
			$('#resultmPoint').text(resultmPoint);
		} 
		
		// 로그인 안되어 있을 시 접근제한
		(function(){
			var loginDTO = '${loginDTO}';
			if( loginDTO == null || loginDTO == '' ){
				alert('비정상적인 접근입니다.');
				location.href='memberLoginPage';
			}else {
				return;
			}
		 	
		})();
	});
	
	

</script>

<div class="order-result wrap">
	<h1 class="page-title">주문이 완료되었습니다</h1>
	<table>
		<tr>
			<td>총 구매 금액</td>
			<td colspan="2"><span><fmt:formatNumber value="${total_price - usemPoint}" pattern="#,##0"/></span></td>
		</tr>
		<tr>
			<td>기존 포인트 : <span>${mPoint }</span></td>
			<c:choose>
				<c:when test="${usemPoint eq 0 }">					
					<td>추가된 포인트 : <span id="addmPoint"></span></td>					
				</c:when>
				<c:otherwise>
					<td>사용된 포인트 : <span id="usemPoint"></span></td>			
				</c:otherwise>
			</c:choose>
			<td>잔여 포인트 : <span id="resultmPoint"></span></td>
			
		</tr>
	</table>
	
	<div class="mygrade-box">
   		<table>
   			<tr>
   				<th rowspan="2" class="bold">나의등급현황</th>
   				<th>구매 실적</th>
   				<th>현재 회원등급</th>
   				<th>다음 등급까지 남은 금액</th>
   				<th rowspan="2">
   					<ul>
   						<li>   						
		   					<span><fmt:formatNumber value="${totalPrice/gradeChangeLimit*100}" pattern="0.00" />%</span>
   						</li>
   						<li>   						
		   					<span>${loginDTO.mGrade }<progress  value="${totalPrice/gradeChangeLimit*100}" max="100"></progress>${nextGrade}</span>
   						</li>
   					</ul>
   					
   				</th>
   			</tr>
   			<tr>
   				<td><span><fmt:formatNumber value="${totalPrice}" pattern="#,##0" /></span></td>
   				<td class="mem-grade"><span>${loginDTO.mGrade}</span></td>
   				<td><span><fmt:formatNumber value="${gradeChangeLimit-totalPrice}" pattern="#,##0" /></span></td>
   			</tr>
   		</table>
   	</div>
	
	<div class="btn-box">
		<input type="button" value="메인 화면으로 가기" onclick="location.href='/cset'"/> &nbsp;&nbsp;
		<input type="button" value="구매한 상품 목록 보기" onclick="location.href='memberOrderViewPage?mNo=${loginDTO.mNo }&mId=${login.mId}'" />	
	</div>
	
</div>


	

<%@ include file="../template/footer.jsp" %>