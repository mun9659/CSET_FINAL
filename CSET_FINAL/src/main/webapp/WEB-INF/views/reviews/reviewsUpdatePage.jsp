<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="리뷰 수정" name="pageTitle"/>
</jsp:include>
	<div class="review-insert wrap" >
		<h1 class="page-title">리뷰 수정</h1>
		
		<form enctype="multipart/form-data" method="POST">
			<table class="centered">
    		<tr>
    			<td colspan="2">
    				<textarea name="rContent" autofocus>${rDTO.rContent }</textarea><br/>		
    			</td>    			
    		</tr>
    		<tr>
    			<td>
    				 <select name="rRating" >
			            <option value="5">★★★★★             아주 좋아요</option>
			            <option value="4">★★★★☆      맘에 들어요</option>
			            <option value="3">★★★☆☆             보통이에요</option>
			            <option value="2">★★☆☆☆            그냥 그래요</option>
			            <option value="1">★☆☆☆☆            별로에요</option>
			          </select>
    			</td>
    			<td>
    				<label>첨부파일 <input type="file" name="rFilename" value="${rDTO.rFilename }"></label>
    			</td>    			
    		</tr>
    		<tr>
    			<td colspan="2">
    				<input type="hidden" name="rNo" value="${rDTO.rNo }"/>
					<input type="hidden" name="pNo" value="${rDTO.pNo }"/>
					<input type="hidden" name="mId" value="${rDTO.mId }"/>   		     	   
					<input type="button" value="수정하기" onclick="fn_reviewsUpdate(this.form)" />
					<input type="button" value="뒤로 가기" onclick="history.back()" />
    			</td>
    		</tr>
    	</table>	
 		</form>
	</div>
	
<%@ include file="../template/footer.jsp" %>