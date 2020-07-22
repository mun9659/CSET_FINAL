<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="${bDTO.bNo }번 게시글" name="pageTitle"/>
</jsp:include>

	<!-- 넘어오는 정보 -->
	<!-- bList : 질문글과 답글 모두-->
	<!-- page : 게시글이 있는 페이지의 정보. 목록으로 되돌아갈 때 이용 -->

	<div class="board wrap">
		<div class="board-title">
			<h1>FAQ</h1>
		</div>		
		<table>
			<c:forEach var="bDTO" items="${bList }">
				<tr>
					<th colspan="2" class="faq-class">
						<!-- bDepth에 따라 질문글과 답글 나눔 -->
						<h2>
							<c:if test="${bDTO.bDepth eq 0 }">
								질문 글
							</c:if>
							<c:if test="${bDTO.bDepth gt 0 }">
								답글
							</c:if>
						</h2>
					</th>							
				</tr>
				<tr>
					<th colspan="2" class="view-title">${bDTO.bTitle }</th>				
				</tr>
				<tr>
					<td colspan="2">
						<pre>${bDTO.bContent }</pre>
						<c:if test="${bDTO.bFilename ne null and bDTO.bFilename ne '' }">
							<img class="board-img" alt="${bDTO.bFilename}" src="${pageContext.request.contextPath}/resources/boardStorage/${bDTO.bFilename}"/>				
						</c:if>
					</td>
				</tr>	
			</c:forEach>
			<tfoot>
				<tr>
					<td colspan="2">
						<button onclick="location.href='boardListPage?bClass=2'">FAQ 목록</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

<%@ include file="../template/footer.jsp" %>