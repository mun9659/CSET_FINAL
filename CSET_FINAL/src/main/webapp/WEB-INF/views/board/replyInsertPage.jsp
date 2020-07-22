<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="게시글 작성" name="pageTitle"/>
</jsp:include>


	
	<script type="text/javascript">
		function fn_boardInsert(f){
			// 비밀번호 입력했는지 확인 (4자)
			if( f.bPw.value.length != 4 ){
				alert('4글자의 비밀번호를 입력해주세요');
				f.bPw.focus;
				return;
			} else {
				f.action = "replyInsert";
				f.submit();
			}
			
		}
	</script>

	<div class="board-insert wrap">
		<form class="board-insert-form" method="post" enctype="multipart/form-data">
			<table>				
				<tr>
					<th>제목</th>
					<td><input type="text" name="bTitle"/></td>
				</tr>
				<tr>
					<th>비밀번호(4자)</th>
					<td><input type="password" name="bPw"/></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="bContent" rows="10" cols="50"></textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="bFilename"/></td>
				</tr>
				<tr>
					<td colspan="2">						
						<input type="hidden" name="bNo"	value="${bDTO.bNo }"/>		<!-- 원글 bNo -->						
						<input type="hidden" name="mId" value="${loginDTO.mId }" />	<!-- 작성자(사용자ID) -->						
						<input type="hidden" name="bClass" value="${bDTO.bClass }" /><!-- 현재 게시글 종류  -->
									
						<button class="board-insert-btn" type="button" onclick="fn_boardInsert(this.form)">게시하기</button>
						<button class="board-insert-btn" type="reset">다시 작성</button>
						<button class="board-insert-btn" type="button" onclick="history.back()">목록</button>
					</td>
				</tr>
			</table>	
		</form>
	</div>


<%@ include file="../template/footer.jsp" %>