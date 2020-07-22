<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="게시글 작성" name="pageTitle"/>
</jsp:include>


	<div class="board-insert wrap">
		<h2 class="board-title">
			<c:if test="${bClass eq 0 }">
				새 공지사항 작성
			</c:if>
			<c:if test="${bClass eq 1 }">
				새 Q&amp;A 작성
			</c:if>
		</h2>
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
					<td colspan="2"><textarea name="bContent"></textarea></td>
				</tr>
				<tr>
					<th>첨부 파일</th>
					<td><input type="file" name="bFilename"/></td>
				</tr>
				<tr>
					<td colspan="2">
					
						<!-- 작성자(사용자ID) -->
						<input type="hidden" name="mId" value="${loginDTO.mId }" />
						<!-- 현재 게시글 종류  -->
						<input type="hidden" name="bClass" value="${bClass }" />
									
						<button class="board-insert-btn"  type="button" onclick="fn_boardInsert(this.form)">게시하기</button>
						<button class="board-insert-btn"  type="reset">다시 작성</button>
						<button class="board-insert-btn"  type="button" onclick="history.back()">목록</button>
					</td>
				</tr>
			</table>	
		</form>
	</div>


<%@ include file="../template/footer.jsp" %>