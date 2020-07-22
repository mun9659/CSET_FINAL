<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<jsp:include page="../template/header.jsp">
   <jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">
(function(){
	var loginDTO = '${loginDTO}';
	if( loginDTO == null || loginDTO == '' ){
		alert('비정상적인 접근입니다.');
		location.href='memberLoginPage';
	}else {
		return;
	}
 	
})();


</script>

<div class="mypage wrap">
   <h1 class="page-title">마이페이지</h1>
   
   <div class="my-menu">
      <ul>
         <li><a href="memberOrderViewPage?mNo=${loginDTO.mNo}&mId=${loginDTO.mId}"><i class="fas fa-truck"></i>주문/배송조회</a></li>
         <li><a href="cartListPage?mId=${loginDTO.mId }"><i class="fas fa-shopping-cart"></i>장바구니</a></li>
         <li><a href=""><i class="fab fa-product-hunt"></i>포인트 : <span class="my-points bold">${loginDTO.mPoint }</span></a></li>
         <li><a href="myContentViewPage?mId=${loginDTO.mId }"><i class="fas fa-file-alt"></i>내가 쓴 글</a></li>
         <li><a href="boardListPage?bClass=2"><i class="fas fa-comments"></i>FAQ</a></li>
      </ul>
   </div>
   
   <h2 class="page-subtitle">${loginDTO.mName}님 회원정보입니다.</h2>
       
   <div class="mygrade-box">
   		<table>
   			<tr>
   				<th rowspan="2" class="bold">나의등급현황</th>
   				<th>구매 실적</th>
   				<th>현재 회원등급</th>
   				<th>다음 등급까지 남은 금액</th>
   				<th rowspan="2">
   					<ul>
   						<li>   						
		   					<span><fmt:formatNumber value="${totalPrice/gradeChangeLimit*100}" pattern="0.00" />%</span>
   						</li>
   						<li>   						
		   					<span>${loginDTO.mGrade }<progress  value="${totalPrice/gradeChangeLimit*100}" max="100"></progress>${nextGrade}</span>
   						</li>
   					</ul>
   					
   				</th>
   			</tr>
   			<tr>
   				<td><span><fmt:formatNumber value="${totalPrice}" pattern="#,##0" /></span></td>
   				<td class="mem-grade"><span>${loginDTO.mGrade}</span></td>
   				<td><span><fmt:formatNumber value="${gradeChangeLimit-totalPrice}" pattern="#,##0" /></span></td>
   			</tr>
   		</table>
   	</div>
   
   <!-- 07.15 추가한 부분 -->
   <script type="text/javascript">
   		function fn_memberUpdate(f){
   			if ( confirm('회원 정보를 수정하시겠습니까?') ){
   				f.action = "memberUpdate";
   				f.submit();
   			}
   		}
   		
   		function fn_memberUpdatePw(f){
   			f.action="memberemailAuth";
   			f.submit();
   		}
   </script>
   
   
    <form method="POST">
      <table class="my-view">
         <tbody>
            <tr>
               <td>회원번호</td>
               <td>
               		<span>${loginDTO.mNo}</span>
               		<input id="mNo" type="hidden" name="mNo" value="${loginDTO.mNo}" readonly />
               </td>
            </tr>
            <tr>
               <td>아이디</td>
               <td>
               		<span>${loginDTO.mId}</span>
               		<input id="mId" type="hidden" name="mId" value="${loginDTO.mId}" readonly />
               </td>
            </tr>
            <tr>
               <td>성명</td>
               <td><input id="mName" type="text" name="mName" value="${loginDTO.mName}" /></td>
            </tr>
            <tr>
               <td>이메일</td>
               <td><input id="mEmail" type="text" name="mEmail" value="${loginDTO.mEmail}" /></td>
            </tr>
            <tr>
               <td>전화번호</td>
               <td><input id="mPhone" type="text" name="mPhone" value="${loginDTO.mPhone}" /></td>
            </tr>
            <tr>
               <td>주소</td>
               <td><input id="mAddress" type="text" name="mAddr" value="${loginDTO.mAddr}" /></td>
            </tr>
            <tr>
               <td>등급</td>
               <td>
               		<span>${loginDTO.mGrade}</span>
               		<input id="mGrade" type="hidden" name="mGrade" value="${loginDTO.mGrade}"readonly />
               </td>
            </tr>
            <tr>
               <td>포인트</td>
               <td>
               		<span>${loginDTO.mPoint}</span>
               		<input id="mPoint" type="hidden" name="mPoint" value="${loginDTO.mPoint}"readonly />
               </td>
            </tr>
            <tr>
               <td>누적금액</td>
               <td>
               		<span>${totalPrice}</span>
               		<input id="totalPrice" type="hidden" name="totalPrice" value="${totalPrice}"readonly />
               </td>               	
            </tr>
            <tr>
               <td>가입일</td>
               <td>${loginDTO.mRegdate}
            </tr>
         </tbody>
      </table>
      <div class="btn-box">
      	 <input id="" type="hidden" name="mPw" value="${loginDTO.mPw}"/>
         <input  type="button" value="회원정보수정하기" onclick="fn_memberUpdate(this.form)"/>
         <input  type="button" value="회원탈퇴하기" onclick="fn_memberLeavePage(this.form)" />
      </div>
   </form>
</div>

<%@ include file="../template/footer.jsp" %>