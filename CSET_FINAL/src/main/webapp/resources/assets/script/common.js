/*---------------------------------------------------------
 *		header.jsp
 --------------------------------------------------------*/
function fn_memberLogout() {
	swal({
		  title: "로그아웃 하시겠습니까?",
		  text: "",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			location.href = 'memberLogout';
		    swal("Poof! Your imaginary file has been deleted!", {
		      icon: "success",
		    });
		  } else {
		    swal("로그아웃을 취소합니다");
		  }
		});
};


	
function fn_memberleave(){
	if(confirm('정말 회원탈퇴를 하시겠습니까?')){
		location.href = 'memberLeavePage';
	}
}



/*---------------------------------------------------------
 *		INDEX (SWIPER)
 --------------------------------------------------------*/
var mySwiper = new Swiper('.swiper-container', {
	  // Optional parameters
	  direction: 'horizontal',
	  loop: true,

	  

	  // Navigation arrows
	  navigation: {
	    nextEl: '.fa-chevron-circle-left',
	    prevEl: '.fa-chevron-circle-right',
	  },

	  // 자동으로 넘어가기
	  autoplay: {
		  delay: 5000
	  },
});




/*---------------------------------------------------------
 *		BOARD
 --------------------------------------------------------*/

// 게시글 수정 및 삭제시 비밀번호 입력 여부, 일치 여부 검사



// 게시글 작성 시 4글자의 비밀번호 입력했는지 확인하기
function fn_boardInsert(f){
	// 비밀번호 입력했는지 확인 (4자)
	if( f.bPw.value.length != 4 ){
		alert('4글자의 비밀번호를 입력해주세요');
		f.bPw.focus;
		return;
	} else {
		f.action = "boardInsert";
		f.submit();
	}
	
}

// 관리자 권한으로 Q&A 게시글 삭제
function fn_adminDelete(f) {
	if( confirm('**관리자 권한으로 삭제**\n정말로 삭제하시겠습니까?') ) {
		f.action="boardDelete";
		f.submit();
	}
}

/*---------------------------------------------------------
 *		MEMBERS
 --------------------------------------------------------*/
// 1. memberLoginPage.jsp

// 1-1) 로그인 페이지 이동
function fn_memberLogin(f) {
	if( $("mId").val() == '' ){
		alert('아이디를 입력해주세요.');
	} else {
		if( $('mPw').val() == '' ){
			alert('비밀번호를 입력해주세요');
		}else {
			f.action = 'memberLogin';
			f.submit();			
		}
	}
}

// 1-2) 아이디 기억하기
function fn_saveIdCheck() {
	
	// 아이디 
	var savedID = getCookie("savedID");
	$('#mId').val(savedID);
	
	// savedID 가 있으면, 체크박스를 체크 상태로 유지
	if ( $('#mId').val() != '' ) {
		$('#saveIDCheck').attr('checked', true);
	}
	
	// 체크박스의 상태가 변하면,
	$('#saveIDCheck').change(function(){
		// 체크되어 있다
		if ( $('#saveIDCheck').is(':checked') ) {
			setCookie( "savedID", $('#mId').val(), 7 );  // 7일간 쿠키에 보관
		} 
		// 체크해제되어 있다.
		else {
			deleteCookie( "savedID" );
		}
	});
	
// 아이디를 입력할 때
	$('#mId').keyup(function(){
		// 체크되어 있다
		if ( $('#saveIDCheck').is(':checked') ) {
			setCookie( "savedID", $('#mId').val(), 7 );  // 7일간 쿠키에 보관
		}
	});	
}


// 2. memberViewPage
function fn_memberLeavePage(f){
	if(confirm('정말 회원탈퇴 하시겠습니까?')){
		f.action = 'memberLeavePage';
		f.submit();
	}
}


function fn_memberOrderViewPage(f){
	if(confirm('주문페이지로 이동하시겠습니까?')){
		f.action = 'memberOrderViewPage';
		f.submit();
	}	
		
}


// 3. memberInsertPage.jsp
//function fn_memberInsert(f) {
//	 //아이디확인
//		if (f.mId.value == "") {
//			swal( "아이디를확인하세요","","info" );			
//			f.mId.focus();
//			return;
//		}
//	//비빌번호확인	
//		if (f.mPw.value == "") {
//			swal({
//			    title: "비밀번호를 입력한 뒤 확인하세요.",
//			    text: "",
//			    icon: "warning" //"info,success,warning,error" 중 택1
//			});
//			f.mPw.focus();
//			return;
//		}
//	//비밀번호2차확인	
//		if (f.mPw.value != f.mPw2.value) {
//			
//			swal({
//			    title: "비밀번호가 일치하지않습니다.",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//	//성명확인	
//		if (f.mName.value == "") {			
//			swal({
//			    title: "성명을 입력하세요.",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//	//주민등록확인	
//		if (f.mSno.value == "") {			
//			swal({
//			    title: "주민등록번호를 입력해주세요",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//	//전화번호를 입력해주세요	
//		if (f.mPhone.value == "") {			
//			swal({
//			    title: "전화번호을 입력하세요.",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//	//이메일을 입력해주세요	
//		if (f.mEmail.value == "") {			
//			swal({
//			    title: "이메일을입력하세요.",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//	//주소를 입력해주세요	
//		if (f.mAddr.value == "") {			
//			swal({
//			    title: "주소를입력하세요.",
//			    text: "",
//			    icon: "error"
//			});
//			f.mPw.focus();
//			return;
//		}
//		
//	//개인정보약관동의
//		 var req = document.j.req.checked;
//		if (!req) {
//			swal({
//			    title: "개인정보약관에동의하셔야됩니다.",
//			    text: "",
//			    icon: "error" 
//			});
//			f.mPw.focus();
//			return;
//		}
//		
//		
//		f.action = 'memberInsert';
//		f.submit();
//	}

//--------------- 쿠키 저장 함수 모음 ----------------

// 1. 쿠키 만들기
function setCookie( cookieName, value, exdays ) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

// 2. 쿠키 삭제
function deleteCookie( cookieName ) {
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

// 3. 쿠키 가져오기
function getCookie( cookieName ) {
    cookieName = cookieName + "=";
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = "";
    if ( start != -1 ){
        start += cookieName.length;
        var end = cookieData.indexOf(";", start);
        if(end == -1) {
            end = cookieData.length;
        }
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}


// 4. memberListPage.jsp
function fn_memberOrderTotalListPage(f) {
	f.action='memberOrderTotalListPage';
	f.submit();
}


// 5. memberProductInsertPage.jsp
function fn_memberProductInsert(f){	
	f.action = 'memberProductInsert';
	f.submit();
}
//-------------------------------------------------------




/*---------------------------------------------------------
 *		CART
 --------------------------------------------------------*/
/* 		함수 ↓↓↓ 	*/
function fn_cartPlusCalc(f) {
	var cAmount = f.cAmount.value;
	if (parseInt(cAmount) >= 10) {
		alert('1 미만 10 초과 되는 수량은 안됩니다.');
		return;
	} else {			
		f.action = 'cartPlusCalc';
		f.submit();
	}
}
function fn_cartMinusCalc(f) {
	var cAmount = f.cAmount.value;
	if (parseInt(cAmount) <= 1) {
		alert('1 미만 10 초과 되는 수량은 안됩니다.');
		return;
	} else {
		f.action = 'cartMinusCalc';
		f.submit();
	}
	
}

function fn_cartCancel() {
	if (confirm('취소하시겠습니까?')) {
		history.back();
	}
}

function fn_orderPage(f) {
	f.action = 'orderInsert';
	f.submit();
}


/*---------------------------------------------------------
 *		REVIEWS
 --------------------------------------------------------*/
function fn_reviewsUpdate(f) {
	f.action = 'reviewsUpdatePage';
	f.submit();
}

function fn_reviewsList(f) {
	f.action = 'productsViewPage';
	f.submit();
}

function fn_reviewsDelete(f) {
	if(confirm('리뷰를 삭제할까요?')) {
		f.action = 'reviewsDeletePage';
		f.submit();
	}
}
/*---------------------------------------------------------
 *		BOARD
 --------------------------------------------------------*/
/*---------------------------------------------------------
 *		BOARD
 --------------------------------------------------------*/
/*---------------------------------------------------------
 *		BOARD
 --------------------------------------------------------*/