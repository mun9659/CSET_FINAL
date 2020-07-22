<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 공지사항 게시판 -->

<jsp:include page="../template/header.jsp">
	<jsp:param value="공지사항" name="pageTitle"/>
</jsp:include>

	<section class="board wrap">
		<div>
		
			<!-- 넘어오는 데이터 -->
			<!-- bList : 검색된 게시글들의 정보(bDTO) 담은 리스트 -->
			<!-- bClass : 게시글의 종류에 따라 제목을 다르게 출력하기 위함 -->
			<!-- page : 현재 페이지 정보 -->
			
			<div class="board-nav">
				<ul>
					<li><a href="boardListPage?bClass=0">공지사항</a></li>
					<li><a href="boardListPage?bClass=1">Q&amp;A</a></li>
					<li><a href="boardListPage?bClass=2">FAQ</a></li>
				</ul>
			</div>
		
			<!-- 게시판 제목(NOTICE/Q&A/FAQ) -->
			<h1 class="board-title">
				NOTICE
			</h1>
			
			<!-- bList에 정보가 없을 경우 -->
			
			<table class="board table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>게시일</th>
						<th>조회수</th>							
					</tr>					
				</thead>
				<tbody>
					<c:if test="${empty bList}">
						<tr>
							<td colspan="5">
								<h1 class="notice">표시할 정보가 없습니다</h1>
							</td>
						</tr>
					</c:if>
					<!-- bList에 정보가 있을 경우 -->
					<c:if test="${not empty bList }">					
						<!-- 게시판 list 출력 -->
						<c:forEach var="bDTO" items="${bList}">
							<tr>
								<td>${bDTO.bNo }</td>			
								<td>
									<a href="boardViewPage?bNo=${bDTO.bNo}&page=${page}">
										${bDTO.bTitle }
									</a>
								</td>			
								<td>${bDTO.mId }</td>			
								<td>${bDTO.bRegdate }</td>			
								<td>${bDTO.bHit }</td>
							</tr>			
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>				
					<tr>
						<td colspan="5">
							${pageView }
						</td>
					</tr>				
				</tfoot>					
			</table>
			
			<!-- 검색창 -->
			<div class="query-box">
				<form action="boardQuery">
					<select name="queryType">
						<option value="bTitle">제목</option>
						<option value="bContent">내용</option>
						<option value="mId">작성자</option>
						<option value="bTitleContent">제목 + 내용</option>
					</select>
					<input type="text" name="query" placeholder="게시글 검색"/>
					<!-- 게시판 종류에 따른 검색 결과 보여주기 위해 bClass도 보내준다 -->
					<input type="hidden" name="bClass" value="0"/>
					
					<button>검색하기</button>
				<!-- 공지사항 작성은 관리자만! -->
				</form>
				<c:if test="${loginDTO.mId eq 'ADMIN' }">
					<button onclick="location.href='boardInsertPage?bClass=0'">글 작성하기</button>
				</c:if>			
				
			</div>
		</div>
	</section>

<%@ include file="../template/footer.jsp" %>
	
