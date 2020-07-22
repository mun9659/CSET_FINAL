<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="게시글 수정" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
	function fn_update(f){
		f.action="boardUpdate";
		f.submit();
	}
</script>

	<div class="board-insert wrap">
		<form class="board-insert-form" method="post" enctype="multipart/form-data">
			<table>				
				<tr>
					<th>제목</th>
					<td><input type="text" name="bTitle" value="${bDTO.bTitle }"/></td>
				</tr>				
				<tr>
					<td colspan="2"><textarea name="bContent" rows="10" cols="80">${bDTO.bContent }</textarea></td>
				</tr>
				<tr>
					<th>기존 파일</th>							
					<td>
						<c:choose>
							<c:when test="${bDTO.bFilename eq null or bDTO.bFilename eq ''}">
								<span class="notice">업로드 된 파일이 없습니다</span>
							</c:when>
							<c:otherwise>
								<a href="boardDownload?bFilename=${bDTO.bFilename }">${bDTO.bFilename }</a>
							</c:otherwise>							
						</c:choose>	
					</td>
				</tr>
				<tr>
					<th>새로운 파일<span class="alert"><br/>(업로드 시 기존 파일 삭제)</span></th>					
					<td>
						<input type="file" name="bFilename"/>
						<!-- 삭제 위해 기존 파일 이름 넘기기 -->
						<input type="hidden" name="beforeFile" value="${bDTO.bFilename }"/>
					</td>
				</tr>				
				<tr>
					<td colspan="2">
						<input type="hidden" name="bNo" value="${bDTO.bNo }" />
						<input type="hidden" name="page" value="${page }"/>					
						<button type="button" onclick="fn_update(this.form)">수정하기</button>
						<button type="reset">다시 작성</button>
						<button type="button" onclick="history.back()">수정 취소</button>
					</td>
				</tr>
			</table>	
		</form>
	</div>

<%@ include file="../template/footer.jsp" %>