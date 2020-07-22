<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="페이지 제목" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
	
	var result = '${result}';
	
	if (result == 1){
		
	} else {	
		if(confirm('장바구니에 추가 완료하였습니다.\n 장바구니로 가실거면 "예", 계속 쇼핑하시려면 "아니요"를 눌러주세요.')){
			location.href = 'cartListPage';
		} else {
			location.href = 'productsListPage';
		}
	}
	
</script>

<%@ include file="../template/footer.jsp" %>