<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="비밀번호 변경" name="pageTitle"/>
</jsp:include>
<!-- 0713 -->

<script type="text/javascript">
 $(document).ready( function(){

 $('#memberChangePwBtn').click(function() {
	$.ajax({
		url:'memberChangePw',
		type:'POST',
		dataType:'json',
		data:'mPw='+ $( '#mPw').val() +'&mId='+ $( '#mId').val(),
		success : function(responseObject) {
			if(true){															
				swal({
				    title: "비밀번호가 변경되었습니다.",
				    text: "",
				    icon: "success" 				    
				});
				
			}else{							
			}
		},	
		error: function() {
			swal({
			    title: "비밀번호를 입력하세요.",
			    text: "",
			    icon: "warning" 
			});
		}					
	});//ajax
});
		
 });//end
			
</script>

변경할 비밀번호를 입력해주세요
<form>
아이디<input id="mId" type="text" name="mId" value="${mId }" readonly="readonly"><br/><br/>
비밀번호<input id="mPw" type="password" name="mPw"><br/><br/>
<input id="memberChangePwBtn" type="button" value="변경하기"><br/><br/>
<input type ="button" value="로그인하러가기" onclick="location.href='memberLoginPage'" /><br/><br/>
</form>
<%@ include file="../template/footer.jsp" %>