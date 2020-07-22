<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="로그인" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">	
	$(document).ready(function(){
		fn_saveIdCheck();		
	});	
</script>

<div class="login-wrap">
	<form method="POST">
	 <h1 class="page-title">LOGIN</h1>
     <p class="login-notice">회원전용 페이지 입니다. 로그인 후 이용하세요.</p>
	 <table>
			<tbody>
				<tr>
					<td><input class="login-input" id="mId" type="text" name="mId" autofocus placeholder="아이디"></td>
				</tr>
				<tr>
					<td><input class="login-input" id="mPw" type="password" name="mPw" placeholder="비밀번호"></td>
				</tr>
				
			</tbody>
			<tfoot>
				<tr>
					<td>
						<button class="login-btn" onclick="fn_memberLogin(this.form)" >로그인</button>
						<button type="button" class="login-btn" onclick="location.href='memberInsertPage'">회원가입</button>
					</td>
				</tr>
				<tr>
					<td>		
						<label class="saveIdChk"><input id="saveIDCheck" type="checkbox" name="saveIDCheck" value="true" checked>&nbsp;아이디 기억하기</label>
					</td>
				<tr>
					<td>	
						<a href="memberFindIdPage">아이디 찾기</a>
						&nbsp;&nbsp;|&nbsp;&nbsp;
						<a href="membeFindPwPage">비밀번호 찾기</a>					
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>






<%@ include file="../template/footer.jsp" %>