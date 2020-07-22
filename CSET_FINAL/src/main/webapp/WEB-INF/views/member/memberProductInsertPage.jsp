<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="../template/errorPage.jsp" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="상품등록 페이지" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">
(function(){
	var loginDTO = '${loginDTO}';
	var mId ='${loginDTO.mId}';
		
	if( loginDTO == null || loginDTO == ''|| !mId.equals("ADMIN") ){
		alert('관리자페이지입니다.');
		location.href='memberLoginPage';
	}else {
		return;
	}
 	
})();
</script>


<div class="product-insert wrap">
<h1 class="page-title">상품등록 페이지</h1>

	<form method="POST" enctype="multipart/form-data">
	<table>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="pName"></td>
		</tr>
		<tr>
			<td>상품가격</td>
			<td><input type="text" name="pPrice"></td>
		</tr>
		<tr>
			<td>상품카테고리</td>
			<td>
				<select name="pCategory">
					<option value="상의">상의</option>
					<option value="하의">하의</option>
					<option value="아우터">아우터</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>세부분류</td>
			<td>
				<select name="pCategory_sub">
					<option value="티셔츠">티셔츠</option>
					<option value="맨투맨후드">맨투맨후드</option>
					<option value="청바지">청바지</option>
					<option value="슬랙스">슬랙스</option>
					<option value="자켓">자켓</option>
					<option value="코트">코트</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>브랜드명</td>
			<td>
				<select name="pBrand">
					<option value="나이키">나이키</option>
					<option value="아디다스">아디다스</option>
					<option value="페이탈리즘">페이탈리즘</option>
					<option value="피스워커">피스워커</option>		
				</select>
			</td>
		</tr>
   		<tr>
            <td>S 사이즈 재고량</td>
            <td><input type="text" name="sAmount_S"/></td>
         </tr>
         <tr>
            <td>M 사이즈 재고량</td>
            <td><input type="text" name="sAmount_M"/></td>
         </tr>
         <tr>
            <td>L 사이즈 재고량</td>
            <td><input type="text" name="sAmount_L"/></td>
         </tr>

		
		<tr>
			<td>등록할파일</td>
			<td><input type="file" name="files" multiple="multiple"></td>
		</tr>
	</table>
	<div class="btn-box">
		<input type="button" value="상품등록" onclick="fn_memberProductInsert(this.form)">
		<input type="button" value="관리자 상품목록" onclick="location.href='memberProductListPage'">
		<input type="button" value="회원 상품목록" onclick="location.href='productsListPage'">
	</div>
											
	</form>
</div>
<%@ include file="../template/footer.jsp" %>