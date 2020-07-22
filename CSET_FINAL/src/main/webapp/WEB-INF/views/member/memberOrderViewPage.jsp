<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="내 주문내역" name="pageTitle"/>
</jsp:include>


<div class="myorders wrap">
	<h1 class="page-title">${loginDTO.mName}님 주문내역 페이지입니다.</h1>
 	<form action="memberOrderPeriodView" class="order-period">
      조회할 기간을 입력하세요&nbsp;&nbsp;&nbsp;&nbsp;
      <input id="startDate" type="date" name="startDate"/>
      &nbsp;&nbsp;~&nbsp;&nbsp;
      <input id="endDate" type="date" name="endDate"/>
      <input type="hidden"  name="mNo" value="${loginDTO.mNo}"/>
      
     <span id="resultOrderPeriod"></span>
     &nbsp;&nbsp;<input type="submit"  value="조회"/>
   </form>


	

	<table>
		<tr>
			<td>주문번호</td>
			<td>상품이미지</td>
			<td>상품이름</td>
			<td>주문일자</td>
			<td>주문금액</td>		
			<td>주문수량</td>		
			<td>배송상태</td>
			<td>리뷰 작성</td>		
					
		</tr>
		
		<c:forEach var="jVO" items="${list}">
		<tr>
			<td>${jVO.oNo}</td>
			<td>
				<div class="product-img review" style="background-image: url('resources/product_photos/${jVO.pFilename}');">
					<img class="blind" src="resources/product_photos/${jVO.pFilename}" alt="제품 이미지">
				</div>
			</td>
			<td><a class="bold" href="productsViewPage?pNo=${jVO.pNo}">${jVO.pName}</a></td>
			<td>${jVO.oDate}</td>		
			<td><fmt:formatNumber value="${jVO.oPrice}" pattern="#,##0"/></td>
			<td>${jVO.oAmount}</td>
			<td>배송준비</td>
			<td>
	         <input type="hidden" value="${jVO.pNo }" name="pNo" />
	         <input type="button" value="리뷰 작성" onclick="location.href='reviewsInsertPage?pNo=${jVO.pNo}'" />
	      </td>	
			
		</tr>
		</c:forEach>
	
	
	
	</table>
</div>
<%@ include file="../template/footer.jsp" %>