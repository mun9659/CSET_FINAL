<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="${bDTO.bNo }번 게시글" name="pageTitle"/>
</jsp:include>

	<!-- 넘어오는 정보 -->
	<!-- bDTO : 세션 영역에 존재하는 bDTO -->
	<!-- page : 게시글이 있는 페이지의 정보. 목록으로 되돌아갈 때 이용 -->

<script type="text/javascript">

function fn_bUpdate( f ) {
	var bPw = '${bDTO.bPw}';
	
	// 비밀번호 확인
	if( bPw == f.bPw.value ) {			
		f.action="boardUpdatePage";
		f.submit();
	} else {
		alert( '잘못된 비밀번호입니다' );
		return;
	}
}		

function fn_bDelete( f ) {
	var bPw = '${bDTO.bPw}';
	
	// 비밀번호 확인
	if( bPw == f.bPw.value ) {
		
		// 삭제 의사 재확인
		if( confirm( '정말로 삭제하시겠습니까?' ) ){
			f.action="boardDelete";
			f.submit();
		}else {
			alert('삭제가 취소되었습니다');
			return;
		}
		
	} else {
		alert( '잘못된 비밀번호입니다' );
		return;
	}
}
</script>

	<div class="board-view wrap">
		<h2 class="board-title">
			<c:if test="${bDTO.bClass eq 0 }">
				NOTICE
			</c:if>
			<c:if test="${bDTO.bClass eq 1 }">
				Q&amp;A
			</c:if>
		</h2>
		<table class="view-table">
			<thead>
				<tr>
					<th colspan="2" class="view-title">${bDTO.bTitle }</th>				
				</tr>
				<tr>
					<td style="border: none">작성자 : ${bDTO.mId }</td>
					<td class="align-right" rowspan="2">조회수 : ${bDTO.bHit }</td>
				</tr>
				<tr>
					<td style="border: none">작성일 : ${bDTO.bRegdate }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="board-content" colspan="2">
					<!-- 공지사항이면 가운데정렬 -->
					<c:if test="${bDTO.bClass eq 0 }">
						<pre class="centered">${bDTO.bContent }</pre>					
					</c:if>
					<c:if test="${bDTO.bClass ne 0 }">
						<pre>${bDTO.bContent }</pre>					
					</c:if>
					
					<!-- 첨부파일이 있을 경우에만 표시 -->
					<c:if test="${bDTO.bFilename ne null and bDTO.bFilename ne '' }">
						<div class="board-img" style="background-image: url('${pageContext.request.contextPath}/resources/boardStorage/${bDTO.bFilename}')">
							<img class="blind" alt="${bDTO.bFilename}" src="${pageContext.request.contextPath}/resources/boardStorage/${bDTO.bFilename}"/>				
						</div>
					</c:if>
					</td>
				</tr>
	
				<tr>
					<td>첨부 파일</td>
					<td>
						<c:if test="${bDTO.bFilename ne null or bDTO.bFilename ne '' }">
							<a href="boardDownload?bFilename=${bDTO.bFilename }">${bDTO.bFilename }</a>
						</c:if>						
						<c:if test="${bDTO.bFilename eq null or bDTO.bFilename eq '' }">
							첨부파일이 없습니다
						</c:if>						
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>
						<!-- 로그인 한 상태 일 때, 그리고 원글이 QNA 글일 경우에만 답글 달기 가능 -->
						<c:if test="${loginDTO ne null and bDTO.bClass eq 1 }">
							<button type="button" onclick="location.href='replyInsertPage'">답글 달기</button>
						</c:if>						
						<button type="button" onclick="location.href='boardListPage?page=${page}&bClass=${bDTO.bClass }'">목록으로 가기</button>					
					
					</td>
					<td>
						<form method="post" class="align-right">					
							<input type="hidden" name="page" value="${page }"/>
							<input type="hidden" name="bNo"	value="${bDTO.bNo }" /> <!-- 답글이 달리는 원글 -->
							<input type="hidden" name="bFilename" value="${bDTO.bFilename }" />	<!-- 삭제할 파일 -->												
							<!-- 내가 작성한 게시글일 경우에만 수정/삭제 가능 -->
							<c:if test="${loginDTO.mId eq bDTO.mId }">
								<button type="button" onclick="fn_bUpdate(this.form)">수정하기</button>
								<button type="button" onclick="fn_bDelete(this.form)">삭제하기</button>
								<input type="password" name="bPw" placeholder="글비밀번호" />
							</c:if>
							<c:if test="${loginDTO.mId eq 'ADMIN' }">
								<button class="admin-btn" type="button" onclick="fn_adminDelete(this.form)">관리자 권한으로 삭제</button>
							</c:if>
						</form>
					</td>							
				</tr>
			</tfoot>
		</table>
	</div>

<%@ include file="../template/footer.jsp" %>