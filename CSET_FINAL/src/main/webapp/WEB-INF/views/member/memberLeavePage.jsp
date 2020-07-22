<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="회원 탈퇴" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
(function(){
	var loginDTO = '${loginDTO}';
	if( loginDTO == null || loginDTO == '' ){
		alert('비정상적인 접근입니다.');
		location.href='memberLoginPage';
	}else {
		return;
	}
 	
})();


</script>

<script type="text/javascript">

	function fn_memberLeave(f) {
		
			alert('정말로탈퇴하시겠습니까?');
		
		f.action='memberLeave';
		f.submit();
	}
</script>
 
<div class="leave wrap">
	<h1 class="page-title">회원탈퇴 페이지</h1>
	<form method="POST">
		<table>
			<tbody>
				<tr>
					<td>탈퇴 아이디</td>
					<td><input id="mId" type="text" name="mId" value="${loginDTO.mId}" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input id="mPw" type="password" name="mPw"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="hidden" name="mNo" value="${loginDTO.mNo}">
						<input type="button" value="회원탈퇴" onclick="fn_memberLeave(this.form)" />
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<%@ include file="../template/footer.jsp" %>