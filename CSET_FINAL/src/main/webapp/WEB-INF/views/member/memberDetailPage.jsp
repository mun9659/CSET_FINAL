<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="회원 상세정보 조회" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">


$(document).ready( function(){
	 
	
//1.회원등급변경		
	$('#updateGradeBtn').click(function(){
		$.ajax({
			url:'memberUpdateGrade',
			type:'POST',
			dataType:'text',
			data:'afterGrade='+ $( '#afterGrade option:selected' ).val() +'&mNo='+ $( '#mNo' ).val(),
			success : function(responseText) {
				var grade=  $('#afterPoint option:selected').val() ;
				 $('#grade').text(responseText);

					swal({
					    title: "등급이변경되었습니다.",
					    text: responseText+"변경",
					    icon: "success" 
					});
				
			},
			error: function() {
				swal({
				    title: "ajax통신실패.",
				    text: "",
				    icon: "warning" 
				});
			}
		});//ajax
	});//btn

	
//2.관리자가 회원 포인트 지급		
    function fn_calcPoint( point, afterPoint ){
           return point+afterPoint;
    }
	
	
	$('#updatePointBtn').click(function(){
		$.ajax({
			url:'memberUpdatePoint',
			type:'POST',
			dataType:'json',
			data:'afterPoint='+ $( '#afterPoint option:selected' ).val() +'&mNo='+ $( '#mNo' ).val(),
			success : function(responseObject) {			
				var point = parseInt( $('#point').text() );
				var afterPoint = parseInt( $('#afterPoint option:selected').val() );

                 $('#point').text( fn_calcPoint( point, afterPoint ));
                 $('#point').css('color', 'blue').css('font-weight', 'bold');
				swal({
				    title: "포인트가 지급되었습니다",
				    text: responseObject.result+"포인트 지급!",
				    icon: "success" 
				});
				
			},
			error: function() {
				swal({
				    title: "ajax통신실패.",
				    text: "",
				    icon: "warning" 
				});
			}
		});//ajax
	});//btn

	
	
	
 });//end
</script>


<div class="member-info wrap">
	<h2 class="page-subtitle">${mDTO.mName}님 개인정보</h2>
	<form method="POST">
      <table class="my-view">
         <tbody>
            <tr>
               <td>회원번호</td>
               <td>
               		${mDTO.mNo}
               		<input id="mNo" type="hidden" name="mNo" value="${mDTO.mNo}" readonly />
               </td>
               
            </tr>
            <tr>
               <td>아이디</td>
               <td>
               		${mDTO.mId}
               		<input id="mId" type="hidden" name="mId" value="${mDTO.mId}" readonly />
               	</td>
            </tr>
            <tr>
               <td>성명</td>
               <td>${mDTO.mName}</td>
            </tr>
            <tr>
               <td>이메일</td>
              	<td>${mDTO.mEmail}</td>
            </tr>
            <tr>
            	<td>전화번호</td>
				<td> ${mDTO.mPhone}</td>
            
            </tr>
            <tr>
               <td>주소</td>
           		<td>${mDTO.mAddr}</td>
            </tr>
            <tr>
               <td>등급</td>
               <td>
               		<ul>
	               		<li>현재 등급 : <span id="grade">${mDTO.mGrade}</span></li>
	               		<li>
		               		<input id="mGrade" type="hidden" name="mGrade" value="${mDTO.mGrade}"readonly />
		               		<select id="afterGrade">			
							 	<option value="A">A등급</option>
							 	<option value="B">B등급</option>
							 	<option value="C">C등급</option>
							 	<option value="D">D등급</option>
							 </select>
							 <input id="updateGradeBtn" type="button" value="등급 변경하기"/>
						 </li>
					 </ul>
               	</td>
            </tr>
            <tr>
               <td>포인트</td>
               <td>
               		<ul>
	               		<li>현재 포인트 : <span id="point">${mDTO.mPoint}</span></li>
	               		<li>
		               		<select id="afterPoint">			
							 	<option value="1000">1000포인트</option>
							 	<option value="2000">2000포인트</option>
							 	<option value="5000">5000포인트</option>
							 	<option value="10000">10000포인트</option>
							 </select>
							<input id="updatePointBtn" type="button" value="포인트 지급하기"/>
						</li>
               		</ul>
               </td>
            </tr>
       <%--      <tr>
               <td>누적 구매금액</td>
               <td>
               		<input id="totalPrice" type="hidden" name="totalPrice" value="${totalPrice}"readonly />
               </td>
            </tr> --%>
            <tr>
               <td>가입일</td>
               <td>${mDTO.mRegdate}
            </tr>
         </tbody>
      </table>
     </form>
  </div>
  
<div class="member-order-detail wrap">
  <h2 class="page-subtitle">${mDTO.mName}님 주문 조회</h2>
  
	<form action="memberOrderPeriodViewPage" class="order-period">
		조회할 기간을 입력하세요&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="startDate" type="date" name="startDate"/>
		&nbsp;&nbsp;~&nbsp;&nbsp;
		<input id="endDate" type="date" name="endDate"/>
		<input type="hidden"  name="mNo" value="${mDTO.mNo}"/>      
		<span id="resultOrderPeriod"></span>
		&nbsp;&nbsp;<input type="submit"  value="조회"/>
   </form>


<!-- 관리자입장에서 보는 회원목록입니다. -->

		
	<table>

		<tr>
			<td>주문번호</td>
			<td>상품이미지</td>
			<td>상품이름</td>
			<td>주문일자</td>
			<td>주문금액</td>		
			<td>주문수량</td>		
			<td>배송상태</td>		
			
		</tr>
		
		<c:forEach var="jVO" items="${list}">
		<tr>
			<td>${jVO.oNo}</td>
			<td>
				<div class="product-img small" style="background-image: url('resources/product_photos/${jVO.pFilename}')">
					<img class="blind" alt="${jVO.pFilename}" src="resources/product_photos/${jVO.pFilename}">
				</div>
			</td>
			<td>${jVO.pName}</td>
			<td>${jVO.oDate}</td>		
			<td>${jVO.oPrice}</td>
			<td>${jVO.oAmount}</td>
			<td>배송중</td>
		</tr>
		</c:forEach>

	</table>
</div>

			
</body>
</html>