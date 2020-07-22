<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp">
   <jsp:param value="회원 가입" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">

function fn_memberInsert(f) {
	 //아이디확인
		if (f.mId.value == "") {
			swal( "아이디를확인하세요","","info" );			
			f.mId.focus();
			return;
		}
	//비빌번호확인	
		if (f.mPw.value == "") {
			swal({
			    title: "비밀번호를 입력한 뒤 확인하세요.",
			    text: "",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});
			f.mPw.focus();
			return;
		}
	//비밀번호2차확인	
		if (f.mPw.value != f.mPw2.value) {
			
			swal({
			    title: "비밀번호가 일치하지않습니다.",
			    text: "",
			    icon: "error"
			});
			f.mPw.focus();
			return;
		}
	//성명확인	
		if (f.mName.value == "") {			
			swal({
			    title: "성명을 입력하세요.",
			    text: "",
			    icon: "error"
			});
			f.mName.focus();
			return;
		}
	//주민등록확인	
		console.log(f.mSno1.value); 
		console.log(f.mSno1.value.length); 
		if (f.mSno1.value == "" || f.mSno1.value.length != 6) {			
			swal({
				title: "주민번호를 확인해주세요",
				text: "",
				icon: "error"
			});
			f.mSno1.focus();
			return;
		}
									
		if (f.mSno2.value == ""  || f.mSno2.value.length != 7) {			
			swal({
				title: "주민번호를 확인해주세요",
				text: "",
				icon: "error"
			});
			f.mSno2.focus();
			return;
		}
		
	//전화번호를 입력해주세요	
	
		var regExpPHONE2 = /^01[0|1|6|9]-[0-9]{3,4}-[0-9]{4}$/;
		if (f.mPhone.value == "") {			
			swal({
			    title: "전화번호을 입력하세요.",
			    text: "",
			    icon: "error"
			});
			f.mPhone.focus();
			return;
		}
	//이메일을 입력해주세요	
	
		var regExpEMAIL = /^[a-z][a-z0-9\-\_]+@[A-Za-z0-9]{3,}(\.[A-Za-z]{2,6}){1,2}$/;
		if ( f.mEmail.value == "" || regExpEMAIL.test(f.mEmail.value.trim()) == false ) {			
			swal({
			    title: "이메일을확인하세요.",
			    text: "",
			    icon: "error"
			});
			f.mEmail.focus();
			return;
		}
	//주소를 입력해주세요	
		if (f.mAddr.value == "") {			
			swal({
			    title: "주소를입력하세요.",
			    text: "",
			    icon: "error"
			});
			f.mAddr.focus();
			return;
		}
		
	//개인정보약관동의
		 var req = document.j.req.checked;
		if (!req) {
			swal({
			    title: "개인정보약관에동의하셔야됩니다.",
			    text: "",
			    icon: "error" 
			});
			
			return;
		}
		
		
		f.action = 'memberInsert';
		f.submit();
	}

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
 
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
 
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
 
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    
    $(document).ready(function(){
    	//1.아이디여부확인
    	$('#idcheckBtn').click(function () {
    		$.ajax({
    			url: 'memberIdCheck',
    			type: 'GET',
    			dataType: 'JSON',
    			data: 'mId=' + $('#mId').val(),
    			success: function(responseObject) {
    				if ( responseObject.result == 'EXIST' ) {
    					$('#idCheckResult').text('이미 가입된 아이디입니다.');
    					$('#idCheckResult').css('color', 'red');
    					
    					swal({
    					    title: "불가능한아이디입니다.",
    					    text: "",
    					    icon: "warning" //"info,success,warning,error" 중 택1
    					});
    				}else{
    					$('#idCheckResult').text('사용할 수 있는 아이디입니다.');
    					$('#idCheckResult').css('color', 'slateblue');
    					swal({
    					    title: "사용가능한아이디입니다.",
    					    text: "",
    					    icon: "success" //"info,success,warning,error" 중 택1
    					});
    				}
    				
    			},
    			error: function(){
    				alert("ajax통신실패");
    			}
    		
    		});
    			
    	});
    	
    	//2.비밀번호확인
    	$('#mPw2').keyup(function() {
    		if ( $('#mPw').val() != $('#mPw2').val() ) {
    			$('#pwConfirmResult').text('비밀번호가 일치하지 않습니다.');
    			$('#pwConfirmResult').css('color', 'red');
    		} else {
    			$('#pwConfirmResult').text('비밀번호가 일치합니다.');
    			$('#pwConfirmResult').css('color', 'slateblue');
    		}
    	});
    			
    	//
    	// 3. 이메일
    	
    	var regExpEMAIL = /^[a-z][a-z0-9\-\_]+@[A-Za-z0-9]{3,}(\.[A-Za-z]{2,6}){1,2}$/;
    	
    	$('#mEmail').keyup(function() {
    		$.ajax({
    			url: 'memberEmailCheck',
    			type: 'POST',
    			dataType: 'JSON',
    			data: 'mEmail=' + $('#mEmail').val(),
    			success: function( responseObject ) {
    				// 정규식 test()
    				if ( regExpEMAIL.test($('#mEmail').val()) ) {
    					// 가입된 이메일 여부 확인
    					if ( responseObject.result == 'EXIST' ) {
    						$('#emailCheckResult').text('이미 가입된 이메일입니다.');
    						$('#emailCheckResult').css('color', 'red');
    					} else {
    						$('#emailCheckResult').text('사용할 수 있는 이메일입니다.');
    						$('#emailCheckResult').css('color', 'slateblue');
    					}
    				} else {  // 정규식을 만족하지 않으면
    					$('#emailCheckResult').text('올바른 이메일 형식이 아닙니다.');
    					$('#emailCheckResult').css('color', 'red');
    				}
    			},
    			error: function() {
    				alert('AJAX 통신이 실패했습니다.');
    			}
    		});
    		
    	});//이메일
    	
    	//전화번호
    	
    	// 4. 전화번호(핸드폰)
    	var regExpPHONE = /^01[0|1|6|9]-[0-9]{3,4}-[0-9]{4}$/;
    	
    	$('#mPhone').keyup(function(){
    		if ( regExpPHONE.test($('#mPhone').val()) ) {
    			$('#phoneCheckResult').text('사용 가능한 번호입니다.');
    			$('#phoneCheckResult').css('color', 'slateblue');
    		} else {
    			$('#phoneCheckResult').text('올바른 전화번호 형식이 아닙니다.');
    			$('#phoneCheckResult').css('color', 'red');
    		}
    	});
    	
    	
    	// 5.주민번호
    	var regExpSno1 =/^[0-9]{6}$/;
    	var regExpSno2 =/^[0-9]{7}$/;
    	
    	$('#mSno1').keyup(function(){
    		if( regExpSno1.test( $('#mSno1').val()) == false ){    			
    			$('#SnoCheckResult').text('유효하지 않은 주민등록번호입니다.');
    			$('#SnoCheckResult').css('color', 'red');
    		}else {
    			$('#SnoCheckResult').text('주민번호 뒷자리를 입력하세요');
    			$('#SnoCheckResult').css('color', 'orange');    			
    		}
    	});
    	$('#mSno2').keyup(function(){
    		if(regExpSno2.test( $('#mSno2').val()) ){
    			$('#SnoCheckResult').text('올바른 주민등록번호입니다.');
    			$('#SnoCheckResult').css('color', 'slateblue');										
    		} else {
    			$('#SnoCheckResult').text('유효하지 않은 주민등록번호입니다.');
    			$('#SnoCheckResult').css('color', 'red');
    		}
    	});

    	
    });//end
    
</script>


      <%
         request.setCharacterEncoding("utf-8");
         String useId = request.getParameter("useId"); // 아이디 중복 체크 후 사용 가능한 아이디면 전달되는 파라미터
      %>
<div class="join wrap">
      <h1 class="page-title">Clothes-Set 회원 가입 페이지</h1>
      <form method="post" name="j">
         <table>
            <tr>
               <td>아이디<sup class="required">*</sup></td>
               <td>
                  <input id="mId" type="text" name="mId" autofocus />
                  <input id="idcheckBtn" type="button" value="아이디체크하기" />
                  <span id="idCheckResult"></span>
               </td>
               
            </tr>
            <tr>
               <td>비밀번호<sup class="required">*</sup></td>
               <td><input type="password" name="mPw" id="mPw"/></td>
            </tr>
            <tr>
               <td>비밀번호확인<sup class="required">*</sup></td>
               <td><input type="password" name="mPw2" id="mPw2" />
               <span id="pwConfirmResult"></span>
               </td>
            </tr>
         
            <tr>
               <td>성명<sup class="required">*</sup></td>
               <td><input type="text" name="mName" /></td>
            </tr>
            <tr>
               <td>주민등록번호</td>
               <td><input type="text" name="mSno1" id="mSno1"/> - <input type="password" name="mSno2" id="mSno2"/>
               <span id="SnoCheckResult"></span></td>
            </tr>
            <tr>
               <td>전화번호</td>
               <td><input type="text" name="mPhone" id="mPhone"/>
               <span id="phoneCheckResult"></span></td>
            </tr>
            
            <tr>
               <td>이메일</td>
               <td><input type="text" name="mEmail" id="mEmail" />
               <span id="emailCheckResult"></span></td>
            </tr>
            <tr>
               <td>주소검색</td>
               <td> <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br></td>
            </tr>
            <tr>
               <td>우편번호</td>
               <td> <input type="text" name="mPno" id="sample4_postcode" placeholder="우편번호"></td>
            </tr>
            <tr>
               <td>도로명주소</td>
               <td> <input type="text" name="mAddr1" id="sample4_roadAddress" placeholder="도로명주소"></td>
            </tr>
            <tr>
               <td>지번주소</td>
               <td> <input type="text" name="mAddr2" id="sample4_jibunAddress" placeholder="지번주소"> </td>
            </tr>
            <tr>
               <td>상세주소주소</td>
               <td><input type="text" name="mAddr" /></td>
            </tr>
         
            <tr>
               <td>약관동의</td>
               <td>
               <textarea rows="15" cols="100">가. 수집하는 개인정보의 항목
첫째, 회사는 회원가 입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.
회원가입
               
   - 이름, 생년월일, 성별, 아이디, 비밀번호, 별명, 연락처(메일주소, 휴대폰 번호 중 선택), 가입인증정보 만14세 미만 아동 회원가입
   - 이름, 생년월일, 성별, 법정대리인 정보, 아이디, 비밀번호, 연락처 (메일주소, 휴대폰 번호 중 선택), 가입인증정보단체아이디 회원가입
   - 단체아이디, 회사명, 대표자명, 대표 전화번호, 대표 이메일 주소, 단체주소, 관리자 아이디, 관리자 연락처, 관리자 부서/직위
   - 선택항목 : 대표 홈페이지, 대표 팩스번호
둘째, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
   - IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록
셋째, 네이버 아이디를 이용한 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 해당 서비스의 이용자에 한해서만 개인정보 추가 수집이 발생할 수 있으며, 이러한 경우 별도의 동의를 받습니다.
넷째, 성인컨텐츠, 유료/게임 등 일부 서비스 이용시 관련 법률 준수를 위해 본인인증이 필요한 경우, 아래와 같은 정보들이 수집될 수 있습니다.
   - 이름, 생년월일, 성별, 중복가입확인정보(DI), 암호화된 동일인 식별정보(CI), 휴대폰 번호(선택), 아이핀 번호(아이핀 이용시), 내/외국인 정보
다섯째, 유료 서비스 이용 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다.
   - 신용카드 결제시 : 카드사명, 카드번호 등
   - 휴대전화 결제시 : 이동전화번호, 통신사, 결제승인번호 등
   - 계좌이체시 : 은행명, 계좌번호 등
   - 상품권 이용시 : 상품권 번호
      나. 개인정보 수집방법회사는 다음과 같은 방법으로 개인정보를 수집합니다.
   - 홈페이지, 서면양식, 팩스, 전화, 상담 게시판, 이메일, 이벤트 응모, 배송요청
   - 협력회사로부터의 제공
   - 생성정보 수집 툴을 통한 수집
               </textarea>
               <br><br>
               <label><input type="checkbox" id ="req" name="req"> 개인정보 수집 및 이용에 동의합니다.</label></td>
            </tr>
         </table>
            <div class="btn-box">
               <button type="button" onclick="fn_memberInsert(this.form)">가입하기</button>
               <button type="reset">다시 작성</button>
               <button type="button" onclick="location.href='memberLoginPage'">로그인하러 가기</button>            
            </div>
      </form>
   </div>
<%@ include file="../template/footer.jsp" %>