<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="${pageContext.request.contextPath}/resources/js/fnLoginCheck.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/changePw.css">

<style>
 @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	.notosanskr * { font-family: 'Noto Sans KR', sans-serif; }
	*{ margin: 0; padding: 0; box-sizing: border-box; font-family: 'Noto Sans KR', sans-serif; font-size: 14px; }

	footer {
		margin-top : 200px;
	}
</style>

<script type="text/javascript">

//이름/비밀번호/핸드폰/생일/성별 --> 이메일은X

	$(document).ready(function(){
		fnCheckSubmit();             // 모든 함수 확인 후 서브밋넘기기
		fnCurrentPwCheck();
		fnNewPwCheck(); // 새 비밀번호 정규식
		fnPwDoubleCheck();
		fnCurrentEmailCheck();
		fnCheckLogin();
	}); 
	
	// 서브밋
	 function fnCheckSubmit(){
	    $('#modify_btn').on('click', function(event){
	      if( confirm('변경하시겠습니까?') == false){
				event.preventDefault(); 
	          return false;
			} else if ( pw_result == false ) {
                event.preventDefault(); 
					Swal.fire({
						text: '현재 비밀번호를 확인해주세요'
					})
                console.log('submit result : ' + pw_result);
                return false;  
            } else if ( new_pw_result == false ) {
                event.preventDefault();  
					Swal.fire({
						text: '새 비밀번호를 확인해주세요'
					})
                console.log('submit new_pw_result : ' + new_pw_result);
                return false;  
            } else if ( pw_double_result == false ) {
                event.preventDefault(); 
					Swal.fire({
						text: '새 비밀번호를 확인해주세요'
					})
                console.log('submit pw_double_result : ' + pw_double_result);
                return false;  
            } else if ( email_result == false ) {
				event.preventDefault();
	    		  Swal.fire({
						text: '이메일을 확인해주세요'
					})
                console.log('submit email_result : ' + email_result);
                return false;  
            } else if ( authCodePass == false ) { 
				event.preventDefault();
	    		  Swal.fire({
						text: '이메일 인증을 진행해주세요'
					})
                console.log('submit authCodePass : ' + authCodePass);
            	return false;
            } else{
            	return true;
            }
	        });
	    } //   function fnCheckSubmit()
	    
	
    // 아이디
	let regId = /^[a-zA-Z0-9_-]{4,}$/;
    // 비밀번호
	let regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;
    // 이름
	let regName = /^[a-zA-Z가-힣]{1,30}$/;
    // 이메일
	let regEmail = /^[0-9a-zA-Z-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}/;
    // 핸드폰 번호
	let pw_result = false;
	let new_pw_result = false;
	let pw_double_result = false;
	let email_result = false;
	let authCodePass = false;
      


/* -------------------------------------------------------------- fnNewPwCheck() ------------------------------------------------ */
      // 새 비밀번호 정규식 
      function fnNewPwCheck(){
         
         $('#newPw').on('blur keyup', function(){
            if( regPwd.test( $("#newPw").val())){    
                $("#new_pw_check").text("사용가능한 비밀번호입니다.").addClass("pass_msg").removeClass('error_msg');
                new_pw_result = true;
            } else if (    $('#newPw').val() == '' ){
                $("#new_pw_check").text('입력은 필수입니다.').addClass('error_msg').removeClass('pass_msg');
                new_pw_result = false;
            }    else {
                $("#new_pw_check").text("비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요.").addClass('error_msg').removeClass('pass_msg');
                new_pw_result = false;
            }
         console.log("newPw: "+pw_result);
            return new_pw_result;
         }); 
      
      } // fnPwCheck
      
/* -------------------------------------------------------------- fnPwDoubleCheck() ------------------------------------------------ */
   // 비밀번호 재확인 일치 
         function fnPwDoubleCheck(){
          
          $('#pwCheck').on('blur keyup', function(){     
                if($('#newPw').val() !=  $("#pwCheck").val() ){
                    $("#pw_doubleCheck").text( '비밀번호가 일치하지 않습니다.').addClass('error_msg').removeClass('pass_msg');
                    pw_double_result = false;
                } else{
                    $("#pw_doubleCheck").text('').removeClass('error_msg').removeClass('pass_msg');
                    pw_double_result = true;
                }  
          console.log("pw2 : "+pw_double_result);
          return pw_double_result;
            });
      }

/* -------------------------------------------------------------- fnSendAuthCode() ------------------------------------------------ */
         function fnSendAuthCode(){
         	
         	$('#authCode_btn').click(function(){
         		$.ajax({
         			url : '/nearby/member/sendAuthCode',
         			type: 'post',
         			data: 'email='+ $('#email').val(),
         			dataType: 'json',
         			success : function(map) {
    					Swal.fire({
    						text: '인증코드가 전송되었습니다.'
    					})
         				fnVerifyAuthcode(map.authCode); // 12/13추가
         			},
         			error: function() {
    					Swal.fire({
    						text: '인증코드 전송 실패'
    					})
     				}
         		});	 // ajax
         	});
         	return;
         } 
/* ------------------------------------------ fnVerifyAuthcode() ------------------------------------ */
      	// 인증코드 검증 변수와 함수
      	function fnVerifyAuthcode(authCode){
      		$('#verify_btn').click(function(){
      			if ( $('#authCode').val() == '' ) {
					Swal.fire({
						text: '인증번호를 입력하세요'
					});
      				authCodePass = false;
      			}else if ( $('#authCode').val() == authCode ) {
					Swal.fire({
						text: '인증되었습니다.'
					});
      				authCodePass = true;
      			} else {
					Swal.fire({
						text: '인증에 실패했습니다.'
					});
      				authCodePass = false;
      			}
      		}); // end click
      	}         
 /* ************************************************************************************ */
         
</script>

<script>

/* ------------------------------------------------------------- fnCurrentPwCheck() ------------------------------------------------- */	
	// 현재 비밀번호 확인 함수
	function fnCurrentPwCheck() {  // checkPassword
	    $('#password_check_btn').on('click',function(){ // TODO ajax로 select 결과 받아서 처리하기해야함.

			$.ajax({
				url : '/nearby/member/checkPassword',
				type : 'post',
				data : 'pw=' + $('#pw').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					console.log(map);
					let name = '${loginUser.name}';
					 if( map.selectResult > 0){
						Swal.fire({
							icon: 'success',
							title: '비밀번호 확인완료',
							text: name + '님의 비밀번호가 확인되었습니다.',
						})
						 pw_result = true;
		             } else if(map.selectResult == 0) {
						Swal.fire({
							icon: 'error',
							title: '비밀번호 재확인필요',
							text: name + '님의 비밀번호가 일치하지 않습니다.',
						})
						 pw_result = false;
					 }
					 console.log(pw_result);
				}, // End Seuccess function
				error : function(xhr, ajaxOptions, thrownError) {
			       console.log(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
	} // End fnCurrentPwCheck
	
	
	
	
/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	
	// 현재 이메일 확인 함수
	function fnCurrentEmailCheck() {  // checkPassword
	    $('#authCode_btn').on('click',function(){ 

			$.ajax({
				url : '/nearby/member/selectByEmail',
				type : 'post',
				data : 'email=' + $('#email').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					console.log(map);
					let name = '${loginUser.name}';
					 if( map.result != null){
						Swal.fire({
							icon: 'success',
							title: '이메일 확인완료',
							text: name + '님의 이메일로 인증번호가 발송되었습니다.',
						})
						fnSendAuthCode(map.result.id);
						 email_result = true;
		             } else if(map.result == null) {
						Swal.fire({
							icon: 'error',
							title: '이메일 재확인필요',
							text: name + '님의 이메일이 일치하지 않습니다.',
						})
						 email_result = false;
					 }
					 console.log(email_result);
				}, // End Seuccess function
				error : function(xhr, ajaxOptions, thrownError) {
			       alert(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
	} // End fnCurrentPwCheck
/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	
    function fnSendAuthCode(id){
    	
   /*  	$('#authCode_btn').click(function(){ */
    		$.ajax({
    			url : '/nearby/member/sendAuthCode',
    			type: 'post',
    			data: 'email='+ $('#email').val(),
    			dataType: 'json',
    			success : function(map) {
    				fnVerifyAuthcode(map.authCode, id); // 12/13추가
    			},
    			error: function() {
					Swal.fire({
						text: '인증코드 전송실패'
					})
				}
    		});	 // ajax
/*     	}); */
    	return;
    }

/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	

   	// 인증코드 검증 변수와 함수
   	function fnVerifyAuthcode(authCode){
   		$('#verify_btn').click(function(){
   			if ( $('#authCode').val() == authCode ) {
				Swal.fire({
					text: '인증되었습니다.'
				})
   				authCodePass = true;
   			} else if ( $('#authCode').val() == '' ) { // 12/14 추가
				Swal.fire({
					text: '인증번호를 입력하세요'
				})
   				authCodePass = false;
   			} else {
				Swal.fire({
					text: '인증에 실패했습니다.'
				})
   				authCodePass = false;
   			}
   			
   		}); // end click
   	}         
	
	/* ----------------------------------------- fnCheckLogin() --------------------------------  */
 	function fnCheckLogin(){
		let loginInfo = '${loginUser.id}';
		if (loginInfo == '') {
			
		 Swal.fire({
				text: '세션이 만료되었습니다. 로그인 화면으로 이동하시겠습니까?',
		        icon: 'warning',
		        showCancelButton: true,
		        confirmButtonColor: '#D4D4D4',  // confirm
		        cancelButtonColor: '#D4D4D4',   // cancel
		        confirmButtonText: '이동',
		        cancelButtonText: '취소'	
		     }).then((result) => {
				if(result.isConfirmed) { // confirm이 false이면 return
					location.href='/nearby/';
				}
		     })
		}
	}	 	
	
</script>	

</head>
<body>


   		<header class="header">
			<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
		</header>

    <div class="form_container" style="margin-top: 160px;">
        <div class="pw_change_box">
    
            <form action="/nearby/member/changePassword" method="post" id="pw_change_form">

                <!-- 비밀번호 -->
                <div class="input_box">
                    <label for="pw">현재 비밀번호</label>
                    <div id="current_pw_box">
	                    <span class="space">
	                  	  <input type="text" id="pw" name="pw">
	                    </span>
	                    <span>
		                    <input type="button" value="확인하기" id="password_check_btn" class="pointer">
	                    </span>
                    </div>
                </div>
                
                <div class="input_box">
                    <label for="newPw">새 비밀번호</label>
                    <span class="space">
                  	  <input type="text" id="newPw" name="newPw">
                    </span>
                    <p id="new_pw_check" class="msg_box"></p>
                </div>

                <!-- 비밀번호 확인 -->
                <div class="input_box">
                    <label for="pwCheck">새 비밀번호 확인</label>
                    <span class="space">
	                    <input type="text" id="pwCheck" >
                    </span>
                    <p id="pw_doubleCheck" class="msg_box"></p>
                </div>

                <!-- 이메일 -->
                <div class="email_box">

                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                    <span class="space">
	                    <input type="text" id="email" name="email">
                    </span>

                    <!-- 인증코드 발송 -->
                    <span class="space">
	                    <input type="button" value="인증번호받기" id="authCode_btn" class="pointer">
                    </span>
                    <span id="email_check"></span>

                    <!-- 인증코드 입력 칸 -->
                    <span class="space">
	                    <input type="text" name="authCode" id="authCode">
                    </span>
                    <input type="button" value="인증하기" id="verify_btn" class="pointer">
                </div>

               <div class="btn_wrap">
                   <button id="modify_btn" class="btn btn-primary pointer">수정완료</button>             
               </div>                    
            </form>
            
        </div>
   
    </div>
    

	  <footer>
           <jsp:include page="/WEB-INF/views/layout/footer.jsp" flush="true" />
      </footer>

</body>
</html>