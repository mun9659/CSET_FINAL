<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="이메일 인증" name="pageTitle"/>
</jsp:include>
<!-- 0713 -->
<script type="text/javascript">

	function fn_emailAuthConfirm(f){
		
		// 인증코드는 ${authKey}
		// 사용자 입력 값은 f.authKey.value
		var authKey = '${authKey}';
		if(authKey != f.authKey.value){
			alert('잘못된 인증코드입니다.');
			return;
		} else {
			alert('인증되었습니다! 비밀번호 변경페이지로 이동합니다.');
			f.action = 'memberChangePwpage';
			f.submit();
		}
	}

</script>

<div class="emailAuth wrap">
	<h1 class="page-subtitle">회원님의 메일로 인증번호가 발송되었습니다</h1>
	<form method="post">
		<label>
			인증코드 
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="text" name="authKey">
		</label>		
		<input type="hidden" name="mId" value="${mId }"/>
		<input type="button" value="인증하기" onclick="fn_emailAuthConfirm(this.form)">
	</form>
</div>
	


<%@ include file="../template/footer.jsp" %>