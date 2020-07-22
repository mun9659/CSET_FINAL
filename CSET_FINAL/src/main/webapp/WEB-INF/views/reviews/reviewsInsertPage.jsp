<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
   <jsp:param value="리뷰 작성" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
   function fn_reviewInsert(f) {
	  if( f.rContent.value.length < 20 ){
		  alert('20자 이상 작성해주세요');
	  } else {
	      alert('리뷰 작성이 완료되었습니다');
	      f.action = 'reviewsInsert';
	      f.submit();		  
	  }
   }
   
</script>
</head>
<body>

    <!-- 고객이 삽입하는 정보 - 내용, 사진, 별점 -->
    <div class="review-insert wrap">
    	<h1 class="page-title">리뷰 작성</h1>
    <form enctype="multipart/form-data" method="POST">
    	<table class="centered">
    		<tr>
    			<td colspan="2">
    				<textarea name="rContent" placeholder="최소 20자 이상 작성해 주세요" autofocus></textarea><br/>		
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
    				<label>첨부파일 <input type="file" name="rFilename"></label>
    			</td>    			
    		</tr>
    		<tr>
    			<td colspan="2">
    			  <input type="hidden" name="pNo" value="${pNo }" />            
			      <input type="hidden" name="mId" value="${loginDTO.mId }" />            
			      <input type="button" value="리뷰 작성 완료 " onclick="fn_reviewInsert(this.form)"/>   
    			</td>
    		</tr>
    	</table>	    
    
   </form>
   </div>
<%@ include file="../template/footer.jsp" %>