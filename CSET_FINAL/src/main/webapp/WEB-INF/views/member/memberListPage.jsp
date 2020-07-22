<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="전체 회원 목록" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
$(document).ready(function(){
//1.관리자 회원삭제      07-14
   $('#memberDeleteBtn').click(function(){
	   if( confirm('회원 삭제를 진행하시겠습니까?') ) {
	        var mIdArray = []; 
	        var mNoArray = [];
	      
	         $('input[name="mId"]:checked').each(function(i){//체크된 리스트 저장
	            mIdArray.push($(this).val());         
	         });
	      
	         $('input[name="mId"]:checked ~ input[type="hidden"]').each(function(i){//체크된 리스트 저장
	        	 mNoArray.push($('.mNo').val());         	          
	         });
	         var objParams = {
	                  "mIdList" : mIdArray  
	                  , "mNoList" : mNoArray
	         };
	         
		      $.ajax({
		         url:'memberDeleteAdmin',
		         type:'post',
		         dataType: "json",
		         contentType :"application/x-www-form-urlencoded; charset=UTF-8",
		         data:objParams,
		         success : function(responseText) {
		            if(true){
		               swal({
		                   title: "회원삭제.",
		                   text: responseText.count+"명 ",
		                   icon: "success" 
		               });
		            }
		         },
		         error: function() {
		            swal({
		                title: "ajax통신실패.",
		                text: "",
		                icon: "warning" 
		            });
		         }
		      });//ajax
		   
	   } else {
		   alert('삭제를 취소합니다');
		   return;
	   } // if end
   });//btn
});


</script>




<div class="memberlist wrap">
	<h1 class="page-title">클로셋 회원목록입니다.</h1>		
	<form action="memberQuery" method="post">	
		<input type="text" name="member-query" placeholder="ID 혹은 이름으로 검색하세요"/>
		<button>회원검색</button>
		<input id="memberDeleteBtn" type="button" value="회원삭제">
	</form>
	<table>
	<!-- 관리자입장에서 보는 회원목록입니다. -->

		<thead>
			<tr>
				<td>번호</td>
				<td>아이디</td>
				<td>성명</td>
				<td>전화</td>
				<td>주소</td>
				<td>이메일</td>
				<td>가입일</td>
				<td>선택</td>				
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="6">연락처 없음</td>
				</tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:forEach var="mDTO" items="${list}">
					<tr>
						<td>${mDTO.mNo}</td>
						<td><a class="bold" href="memberDetailPage?mNo=${mDTO.mNo}">${mDTO.mId }</a></td>
						<td>${mDTO.mName}</td>
						<td>${mDTO.mPhone}</td>
						<td>${mDTO.mAddr}</td>
						<td>${mDTO.mEmail}</td>
						<td>${mDTO.mRegdate}</td>
						<td>
							<c:if test="${mDTO.mId ne 'ADMIN' }">
								<input id="mId" name="mId" type="checkbox"value="${mDTO.mId}"/>	
							</c:if>
							<input class="mNo" name="mNo" type="hidden" value="${mDTO.mNo}"/>	
						</td>
						
						
					</tr>
				</c:forEach>
			</c:if>
		</tbody>	
	</table>
</div>
<%@ include file="../template/footer.jsp" %>