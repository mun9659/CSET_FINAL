<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../template/header.jsp">
   <jsp:param value="관리자 상품 관리 페이지" name="pageTitle"/>
</jsp:include>

<script type="text/javascript">
(function(){
	var loginDTO = '${loginDTO}';
	var mId ='${loginDTO.mId}';
		
	
	if( loginDTO == null || loginDTO == '' ){
		alert('관리자페이지입니다.');
		location.href='memberLoginPage';
	}else {
		return;
	}
 	
})();
	function fn_search(f){
		f.action = 'productsSearch';
		f.submit();
	}
</script>

<div class="admin-prod wrap">

<h1 class="page-title">상품 관리 페이지</h1>

<form>
<table>
   <caption class="blind">관리자 상품페이지 입니다.</caption>
   <thead>
   <tr>
   	<td colspan="9">
   		<input type="text" name="searchBox"/><input type="button" value="검색" onclick="fn_search(this.form)"/>
   	</td>
   </tr>
   <tr>
      <td>상품번호</td>
      <td>상품이름</td>
      <td>상품 이미지</td>
      <td>가격</td>
      <td>대분류</td>
      <td>소분류</td>
      <td>브랜드</td>
      <td>할인율(%)</td>
      <td>할인된가격</td>
   </tr>
   </thead>
   <tbody>
      <c:if test="${empty plist}">
            <tr>
               <td colspan="10">이미지글이 없습니다.</td>
            </tr>
      </c:if>
      <c:if test="${not empty plist}">
            <c:forEach var="pDTO" items="${plist}" varStatus="k">
               <script type="text/javascript">
               
                  function fn_calcPrice( price, disrate ){
                     return price * ( 1 - (disrate/100) );
                  }
               
                   $(document).ready( function(){
                      
                     var k = '${k.index }';
                     
                     var price = parseInt( $('#price'+k).text() );
                     var disrate = parseInt( $('#disrate'+k).text() );
                     
                  /*    $('#pNo'+k).text(k+"번째 아이템");
                     $('#afterPrice'+k).val('12345'); */
                     
                  //1.제품가격변경하기      
                     $('#updatePriceBtn'+k).click(function(){
                        $.ajax({
                           url:'memberUpdatePrice',
                           type:'POST',
                           dataType:'json',
                           data:'afterPrice='+ $( '#afterPrice'+k ).val() +'&pNo='+ $( '#pNo'+k ).val(),
                           success : function(responseObject) {
                              
                              $('#price'+k).text(responseObject.result);                                 
                              $('#price'+k).css('color', 'blue').css('font-weight', 'bold');
                              price = parseInt(responseObject.result);
                              $('#resultPrice'+k).text( Math.round( fn_calcPrice( price, disrate ) /100 )*100 );
                              $('#resultPrice'+k).css('color', 'blue').css('font-weight', 'bold');
                              swal({
                                  title: "가격이변경되었습니다.",
                                  text: "",
                                  icon: "success" //"info,success,warning,error" 중 택1
                              });

                           },
                           error: function() {
                              swal({
                                  title: "가격을입력하세요.",
                                  text: "",
                                  icon: "warning" //"info,success,warning,error" 중 택1
                              });
                           }
                        });//ajax
                     });
                  //2.제품할인률변경하기
                   $('#updateDisrateBtn'+k).click(function() {
                     $.ajax({
                        url:'memberUpdatedisrate',
                        type:'POST',
                        dataType:'json',
                        data:'afterDisrate='+ $( '#afterDisrate'+k ).val() +'&pNo='+ $( '#pNo'+k ).val(),
                        success : function(responseObject) {
                           if(true){                                 
                              $('#disrate'+k).text(responseObject.result+'%');
                              $('#disrate'+k).css('color', 'blue').css('font-weight', 'bold');
                              disrate = parseInt( responseObject.result );
                              $('#resultPrice'+k).text( Math.round( fn_calcPrice( price, disrate ) /100 )*100 );
                              $('#resultPrice'+k).css('color', 'blue').css('font-weight', 'bold');
                              swal({
                                  title: "할인율이 변경되었습니다..",
                                  text: "",
                                  icon: "success" //"info,success,warning,error" 중 택1
                              });
                           }else{                     
                           }
                        },   
                        error: function() {
                           swal({
                               title: "할인율을입력하세요.",
                               text: "",
                               icon: "warning" //"info,success,warning,error" 중 택1
                           });
                        }               
                     });//ajax
                  });
                     
                     
                     
                   });//end
                  
               </script>
                  <tr>                     
                     <td>
                        <span>${pDTO.pNo}</span>
                        <input type="hidden" id="pNo${k.index}" value="${pDTO.pNo}"/>
                     </td>
                     <td>${pDTO.pName}</td>                     
                     <td><img class="product-img small" alt="${pDTO.pFilename}" src="resources/product_photos/${pDTO.pFilename}"></td>
                     
                     <td class="price-change">
                        <span id="price${k.index }">${pDTO.pPrice}</span>
                        <span><input id="afterPrice${k.index }" name="afterPrice" type="text"></span>                        
                        <span><input id="updatePriceBtn${k.index }" type="button" value="가격변경"></span>
                     </td>
                     
                     <td>${pDTO.pCategory}</td>
                     <td>${pDTO.pCategory_sub}</td>
                     <td>${pDTO.pBrand}</td>
                     
                     <td class="price-change">
                        <span id="disrate${k.index }">${pDTO.pDisrate}%</span>
                        <span><input id="afterDisrate${k.index }" name="afterDisrate" type="text"></span>                        
                        <span><input id="updateDisrateBtn${k.index}" type="button" value="할인율변경"></span>
                     </td>               
                     <td>
                        <fmt:parseNumber var="test" integerOnly="true" value="${pDTO.pPrice*(1-(pDTO.pDisrate*0.01))}"/>
                        <span id="resultPrice${k.index }">
                          <%--  ${ (pDTO.pPrice*(1-(pDTO.pDisrate*0.01)) % 100) ge 50 ?  } --%>
                        </span>            
                     </td>                  
                  </tr>
            </c:forEach>
         </c:if>
   </tbody>

</table>
</form>
</div>
<%@ include file="../template/footer.jsp" %>