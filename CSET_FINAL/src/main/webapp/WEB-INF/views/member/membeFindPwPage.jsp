<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 0713 -->
<jsp:include page="../template/header.jsp">
	<jsp:param value="비밀번호 찾기" name="pageTitle"/>
</jsp:include>
<script  type="text/javascript">
function fn_emailAuth(f){
	$.ajax({
		url: 'memberEmailCheck',
		type: 'POST',
		dataType: 'JSON',
		data: 'mEmail=' + $('#mEmail').val(),
		success: function( responseObject ) {
			// 가입된 이메일 여부 확인
			if ( responseObject.result == 'EXIST' ) {
				f.action="memberemailAuth";
				f.submit();					
			} else {
				alert('회원님의 이메일이 아닙니다 \n 다시 입력하세요');
				f.mEmail.focus();
				return;
			}		
		},
		error: function() {
			alert('AJAX 통신이 실패했습니다.');
		}
	});
}
</script>
<div class="find wrap">
	<h1 class="page-title">비밀번호 찾기</h1>
	<form action="memberemailAuth" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mId"/></td>
			</tr>
			<tr>
				<td>가입 당시 이메일</td>
				<td><input type="text" name="mEmail" id="mEmail"></td>
			</tr>
			<tr>
				<td class="btn-box" colspan="2">
					<button type="button" onclick="fn_emailAuth(this.form)" >인증요청</button>
					<button type="button" onclick="location.href='memberLoginPage'">로그인하러 가기</button>
				</td>
		</table>
		
		
	</form>

</div>
	


<%@ include file="../template/footer.jsp" %>