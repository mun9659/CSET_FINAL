<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="회원 아이디찾기" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
// AJAX 를 통해 아이디를 찾는다.
// controller를 거치지 않고 따로 서블릿을 생성하여 별도의 처리를 한다.
	$(document).ready(function(){
	$('#findIdBtn').click(function(){
		$.ajax({
			url: 'memberFindId',
			type: 'POST',
			dataType: 'text',
			data: 'mEmail=' + $('#mEmail').val(),
			success: function(responseText) {
				if ( responseText.trim() != "NO" ) {
					$('#findIdResult').text('회원님의 아이디는 ' + responseText + '입니다.');
					swal({
					    title: "회원님의 아이디는",
					    text: responseText +"입니다",
					    icon: "success" //"info,success,warning,error" 중 택1
					});
					
				} else {
					$('#findIdResult').text('이메일정보를다시확인해주세요.');
					$('#findIdResult').css('color', 'red').css('font-weight', 'bold');
				}
			},
			
			error: function() {
				alert('AJAX 통신이 실패했습니다.');
			}
		});
	});
	});
</script>



</head>
<body>
<div class="find wrap">
	<h1 class="page-title">아이디 찾기</h1>
	<form method="POST">
		<table>
			<tbody>
				<tr>
					<td>가입 당시 이메일</td>
					<td><input id="mEmail" type="text" name="mEmail" autofocus /></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td class="btn-box" colspan="2">
						<button id="findIdBtn" type="button">아이디찾기</button>
						<button type="button" onclick="location.href='membeFindPwPage'">비밀번호찾기</button>
						<button type="button" onclick="location.href='memberLoginPage'">로그인하러가기</button>
					</td>
				</tr>
			</tfoot>
		</table>
		<div id="findIdResult"></div> 
	</form>
</div>
<%@ include file="../template/footer.jsp" %>