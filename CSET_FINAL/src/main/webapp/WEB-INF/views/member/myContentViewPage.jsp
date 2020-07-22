<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
   <jsp:param value="내가 작성한 글" name="pageTitle"/>
</jsp:include>
<!-- rFilename -->
<!-- rRating -->

<div class="myContent wrap">
   <%-- <c:if test="${empty myReviewList }">
         작성한 리뷰가 없습니다.<br/>
         리뷰 넘버${cVO.rNo}<br/> <!-- 히든 처리 -->
         작성 아이디 ${cVO.mId}<br/>
   </c:if>
    --%>   
   <div class="my-reviews">
       <h3 class="page-subtitle">내가 작성한 ${totalMyReviews}개의 리뷰</h3>
      <table>
         <thead>
            <tr>
               <th>상품 이름</th>
               <th>상품 이미지</th>
               <th>내용</th>
               <th>내가 준 별점</th>
               <th>작성일</th>
            </tr>
         </thead>
         <tbody>
            <c:if test="${empty myReviewList }">
               <tr>
                  <td class="notice" colspan="5">작성한 리뷰가 없습니다</td>
               </tr>
            </c:if>
            <c:if test="${not empty myReviewList }" >
               <c:forEach var="cVO" items="${myReviewList}">      
               <!-- mId, rNo- 히든 , rFilename, rRating, rLike, rRegdate -->
                  <!-- 히든 처리 -->
                  <%--    리뷰 넘버 ${cVO.rNo}<br/> 
                        작성 아이디 ${cVO.mId}<br/> --%>
                     <tr>
               
                        <td><a class="bold" href="productsViewPage?pNo=${cVO.pNo}">${cVO.pName }</a></td>
                        <td>
                        	<div class="product-img small" style="background-image: url('${pageContext.request.contextPath}/resources/product_photos/${cVO.pFilename}')">
	                           <img class="blind" alt="${cVO.pFilename}" src="${pageContext.request.contextPath}/resources/product_photos/${cVO.pFilename}">
                        	</div>
                        </td>
                        <td>
                        <div class="review-contents">
                              <span>${cVO.rContent.length() > 200 ? cVO.rContent.substring(0, 200).concat('...') : cVO.rContent}</span>
                              <a href="reviewsViewPage?rNo=${cVO.rNo}">더보기</a>
                           </div>
                        </td>
                        <td>
                           <div class="review-stars">
                              <c:forEach begin="1" end="${cVO.rRating }" step="1">
                                 <i class="fas fa-star fa-2x"></i>
                              </c:forEach>
                              <c:forEach begin="1" end="${5-cVO.rRating }" step="1">
                                 <i class="far fa-star fa-2x"></i> 
                              </c:forEach>
                           </div>
                        </td>
                        <td>
                           ${cVO.rRegdate }
                        </td>
                     <tr>
                  </c:forEach>
               </c:if> 
            </tbody>
         </table>               
      </div>
      
      
      <div class="my-board">
         <h3 class="page-subtitle">내가 작성한 ${totalMyBoard }개의 게시글</h3>
         <table>
            <thead>
               <tr>
                  <th>제목</th>
                  <th>게시일</th>
                  <th>조회수
               </tr>
            </thead>
            <tbody>
            <c:if test="${empty myBoardList }">
               <tr>
                  <td class="notice" colspan="3">작성한 게시글이 없습니다</td>
               </tr>
            </c:if>
            <c:if test="${not empty myBoardList }">
               <c:forEach var="bDTO" items="${myBoardList }">
                  <tr>
                     <td>
                        <a href="boardViewPage?bNo=${bDTO.bNo }">${bDTO.bTitle }</a>
                     </td>
                     <td>${bDTO.bRegdate }</td>
                     <td>${bDTO.bHit }</td>
                  </tr>
               </c:forEach>
            </c:if>            
            </tbody>
         </table>
      </div>
         
      
      
      
</div>


<%@ include file="../template/footer.jsp" %>