<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="Q&A" name="pageTitle"/>
</jsp:include>

	<script type="text/javascript">
		function fn_boardInsertPage() {
			// 로그인 되어있는지 확인(loginDTO가 세션에 있는지 확인)
			var loginDTO = '${loginDTO}';
			
			if( loginDTO == null || loginDTO == '' ){
				if( confirm('로그인 후에만 글을 작성할 수 있습니다.\n로그인 페이지로 이동하시겠습니까?') ) {
					location.href='memberLoginPage';
				} else {
					return;
				}
			} else {
				// 현재 게시판의 종류를 계속 기억하고 있기 위해 넘김
				var bClass = '${bClass}';
				console.log(bClass);
				location.href='boardInsertPage?bClass=' + bClass;
			}
		}
		
		function fn_boardSelectDelete(f){
			if( confirm('정말로 삭제하시겠습니까?') ){
				f.action = 'boardDelete';
				f.submit();
			}
		}
		
	</script>

	<section class="board wrap">	
		
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
				Q&amp;A
			</h1>
			
			<!-- bList에 정보가 없을 경우 -->

			<form action="boardQuery">
				<table class="board table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>게시일</th>
							<th>조회수</th>
							<c:if test="${loginDTO.mId eq 'ADMIN' }">
								<th>글 선택</th>
							</c:if>							
						</tr>					
					</thead>
					<tbody>
						<c:if test="${empty bList}">
							<tr>
								<c:if test="${loginDTO.mId eq 'ADMIN' }">
									<td colspan="6">
										<h1 class="notice">표시할 정보가 없습니다</h1>
									</td>							
								</c:if>
								<c:if test="${loginDTO.mId ne 'ADMIN' }">
									<td colspan="5">
										<h1 class="notice">표시할 정보가 없습니다</h1>
									</td>							
								</c:if>				
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
										<!-- Depth마다 제목 앞에 L re: 붙이기 -->
											<c:if test="${bDTO.bDepth != 0 }">
												<c:forEach begin="1" end="${bDTO.bDepth }" step="1">
													<span>&nbsp;&nbsp;</span>
												</c:forEach>
												<c:forEach begin="1" end="${bDTO.bDepth }" step="1">
													<span>L re:</span>
												</c:forEach>
											</c:if>
											${bDTO.bTitle }
										</a>
									</td>			
									<td>${bDTO.mId }</td>			
									<td>${bDTO.bRegdate }</td>			
									<td>${bDTO.bHit }</td>
									
									<c:if test="${loginDTO.mId eq 'ADMIN' }">
										<td>
											<input type="checkbox" name="bNo" value="${bDTO.bNo }"/>
										</td>
									</c:if>
								</tr>			
							</c:forEach>
						</c:if>
					</tbody>
					<tfoot>				
						<tr>
							<c:if test="${loginDTO.mId eq 'ADMIN' }">
								<td colspan="6">
									${pageView }
								</td>							
							</c:if>
							<c:if test="${loginDTO.mId ne 'ADMIN' }">
								<td colspan="5">
									${pageView }
								</td>							
							</c:if>
						</tr>				
					</tfoot>					
				</table>
				<div class="query-box">
					<div class="query-options">
						<select name="queryType">
							<option value="bTitle">제목</option>
							<option value="mId">작성자</option>
							<option value="bContent">내용</option>
							<option value="bTitleContent">제목 + 내용</option>
						</select>
						<input type="text" name="query" placeholder="게시글 검색"/>
						<!-- 게시판 종류에 따른 검색 결과 보여주기 위해 bClass도 보내준다 -->
						<input type="hidden" name="bClass" value="1"/>
						<button type="submit">검색하기</button>
					</div>
					<div class="btn-box">
						<c:if test="${loginDTO.mId eq 'ADMIN' }">
							<button class="admin-btn" type="button" onclick="fn_boardSelectDelete(this.form)">관리자 권한으로 삭제</button>		
						</c:if>					
						<button type="button" onclick="fn_boardInsertPage()">글 작성하기</button>
					</div>
				</div>
			</form>
	</section>

<%@ include file="../template/footer.jsp" %>
	
