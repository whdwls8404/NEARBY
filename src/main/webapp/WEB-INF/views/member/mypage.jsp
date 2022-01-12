<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보수정</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css">
<script src="${pageContext.request.contextPath}/resources/js/fnLoginCheck.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">


<style>

   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

  /* sweet alert */

   .swal2-styled { margin:  0.5em; }
   .swal2-styled.swal2-confirm { width: 100px; background-color: #d4d4d4;  }
   .swal2-styled.swal2-cancel {width: 100px;}
   .swal2-icon.swal2-warning { color: pink; border-color: pink;}

	.hidden_box {
		z-index: -99;
	    background-color: white;
	    opacity: 0.5;
	    width: 600px;
	    height: 850px;
		margin: 0 auto;
	    border-radius: 30px;
	    padding-bottom: 20px;
	    position: absolute;
	    top: 150px;
	}
	.hidden_class{
		z-index: 2;
	}


	.pointer:hover {
		cursor: pointer;
	}
	
</style>

<script type="text/javascript">

//이름/비밀번호/핸드폰/생일/성별 --> 이메일은X

	$(document).ready(function(){
		fnFindMemberInfo();
		fnBirth();
		fnFileCheck();
		fnProfilePic(); // 프로필 사진 등록
		fnDeleteProfilePic(); // 프로필 사진 초기화
		fnModifyMemberInfo();
		fnLeave();	// 회원탈퇴
		fnCurrentPwCheck(); // 탈퇴시 비밀번호 확인
	}); 
 	 	
    // 아이디
	let regId = /^[a-zA-Z0-9_-]{4,}$/;
    // 이름
	let regName = /^[a-zA-Z가-힣]{1,30}$/;
    // 핸드폰 번호
	let regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	let id_result = false;
	let name_result = false;
	let phone_result = false;
	let pw_result = false;
   
 /* ************************************************************************************ */


/* ------------------------------------------------------------ fnFindMemberInfo() ------------------------------------------------------------ */
	// 회원 조회 함수
	function fnFindMemberInfo(){
	 
		$.ajax({
			 url: '/nearby/member/memberInfo', // url에 param이 아니라, 변수가 포함되어 넘어간다.
			type: 'post',
			dataType: 'json', // 받아오는 data Type
			success: function(map){
				if(map.loginErrorMsg != null) {
					 Swal.fire({
							text: '세션이 만료되었습니다. 로그인 화면으로 이동하시겠습니까?',
					        icon: 'warning',
					        showCancelButton: true,
					        confirmButtonColor: '#D4D4D4',  // confirm
					        cancelButtonColor: '#D4D4D4',   // cancel
					        confirmButtonText: '이동',
					        cancelButtonText: '취소'	
					     }).then((result) =>{
							if(result.isConfirmed) { // confirm이 false이면 return
								location.href='/nearby/';
							}
					     })
				} else if (map.member != null) { 
				let birthday = map.result.birthday;
				console.log(birthday);
				let year = birthday.substring(0,4);
				let month = birthday.substring(4,6);
				let day = birthday.substring(6,8);
					$('#user_name_area').text(map.result.name + '님 환영합니다.');
					$('#mNo').val(map.result.mNo); 
					$('#phone').val(map.result.phone);
					$('#content').val(map.result.profile.pContent);
					$('#name').val(map.result.name);
					$('#birthday').val(year);
					$('#month').val(month);
					$('#day').val(day);
					if (map.result.profile.pOrigin != '') {
						$('#user_img').attr('src', '/nearby/' + map.result.profile.pPath + '/' + map.result.profile.pSaved);
						$('#profile_img').attr('src', '/nearby/' + map.result.profile.pPath + '/' + map.result.profile.pSaved);
					} else {
						$('#user_img').attr('src', '${pageContext.request.contextPath}/resources/image/profile_default.png');
						$('#profile_img').attr('src', '${pageContext.request.contextPath}/resources/image/profile_default.png');
					}
					$('input:radio[name="gender"][value="'+map.result.gender+'"]').prop('checked', true); // prop는 객체에 저장 된 값이므로 true or false가 된다
				} else {
					Swal.fire({
						icon: 'warning',
						title: '회원정보를 찾을 수 없음',
						text: '죄송합니다. 회원님과 일치하는 정보가 없습니다.',
					})
				}
			}
		}) // End ajax
 	} // End fnFindMemberInfo


/* ------------------------------------------------------------ fnFileCheck() ------------------------------------------------------------ */
	// 첨부파일 점검 함수 (확장자 + 크기)
	function fnFileCheck(){
		
		$('#file').on('change', function(){
			/* 확장자 점검 */
			let origin = $(this).val(); // 첨부된 파일명
			let extName = origin.substring(origin.lastIndexOf(".") + 1).toUpperCase(); // 확장자를 대문자로 저장 aaa.aaa.aaa.ccc 일 때, 마지막 마침표 다음 자리부터 끝까지 substring으로 가지고오고 
			if ( $.inArray(extName, ['JPG', 'JPEG', 'GIF', 'PNG', 'JFIF']) == -1 ) {	// 첨부된 파일이 ['JPG', 'JPEG', 'GIF', 'PNG'] 중 하나가 아니면 (-1) :: 확장자 제한 두기
				Swal.fire({
				//	icon: 'warning',
					title: '확장자를 확인해주세요',
					text: '첨부 가능한 이미지의 확장자는 jpg, jpeg, gif, png, jfif 입니다.'
				});
				$(this).val(''); // 첨부 초기화
				return;
			}			
			
			/* 파일크기 점검 */
			let maxSize = 1024 * 1024 * 10;	// 최대 크기 10MB
			let fileSize = $(this)[0].files[0].size; // 첨부된 파일 크기
			if (fileSize > maxSize) {
				Swal.fire({
				//	icon: 'warning',
					title: '파일의 크기를 확인해 주세요',
					text: '10MB 이하의 파일만 사용하실 수 있습니다.'
				});
				$(this).val('');
				return;
			}
			
		}) // change function
		
	} //fn FileCheck
	

/* ------------------------------------------------------------ fnProfilePic() ------------------------------------------------------------ */
	// 프로필 사진 변경
	function fnProfilePic(){
		$('#profile_insert_btn').on('click', function(){
			
			let formData = new FormData();
				let file = $('#file')[0].files[0];
				formData.append('file', file); // 첨부를 FormData에 넣기
				$.ajax({
				url: '/nearby/profile/profilePic',
				type: 'post',
				contentType: false,
				processData: false,
				data: formData,
				enctype: 'multipart/form-data',
				dataType: 'json',
				success: function(map){
					let name = '${loginUser.name}';
					if(map.insertResult && map.insertResult != null) {
						Swal.fire({
							icon: 'success',
							text: name + '님의 프로필 사진등록이 완료되었습니다.',
						})
						$('#file').val('');
						$('.file_box').removeClass('show');
						fnFindMemberInfo();
						$('.hidden_box').removeClass('hidden_class');
					} else if (map.nullMsg != null) {
						console.log(map.nullMsg);
						Swal.fire({
							icon: 'error',
							text: name + '님의 프로필 사진등록을 실패했습니다.',
						})
					} else {
						Swal.fire({
							icon: 'error',
							text: name + '님의 프로필 사진등록을 실패했습니다.',
						})
					}
				} // success
			}) // End ajax
			
		}) // End profile_insert_btn click event
	} // fnProfilePic

/* ------------------------------------------------------------ fnProfilePic() ------------------------------------------------------------ */
	// 사진 삭제
	function fnDeleteProfilePic(){
		$('#delete_btn').on('click', function(){

			$.ajax({
			url: '/nearby/profile/profilePicDelete',
			type: 'post',
			dataType: 'json',
			success: function(map){
				let name = '${loginUser.name}';
				if(map.deleteResult && map.deleteResult != null) {
					Swal.fire({
						icon: 'success',
						text: name + '님의 프로필이 초기화되었습니다.',
					})
					$('#file').val('');
					$('.file_box').removeClass('show');
					fnFindMemberInfo();
					$('.hidden_box').removeClass('hidden_class');
				} else {
					Swal.fire({
						icon: 'error',
						text: name + '님의 프로필이 초기화되지 않았습니다.',
					})
				}
				} // success
			}) // End ajax
		}) // End deleteBtn Click Event
	} //  End fnDeleteProfilePic

/* ---------------------------------------------------------- fnModifyMemberInfo() ------------------------------ */
	// 회원정보 수정하기 modify_btn"
	function fnModifyMemberInfo() {
		$('#modify_btn').click(function(){
	// /nearby/member/modifyMember'
 			let member = JSON.stringify({
				mNo: $('#mNo').val(),
				profile : {pContent : $('#content').val()},
				name: $('#name').val(),
				phone: $('#phone').val(),
				birthday: $('#birthday').val() + $('#month').val() + $('#day').val(),
				gender: $('input:radio[name="gender"]:checked').val()
			}); 
			
			$.ajax({
				url: '/nearby/member/modifyMember',
				type: 'post',
				data: member,
				contentType: 'application/json',
				dataType: 'json',
				success: function(map){
					if(map.result && map.result != null) {
						Swal.fire({
				            icon: 'success',
				            text: map.member.name + '님의 회원정보가 수정되었습니다.',
				        });
						fnFindMemberInfo();
					} else if (map.nullErrorMsg == '올바른 형식이 아닙니다.'){
						Swal.fire({
				            icon: 'error',
				            text: '핸드폰 번호는 11자리 정수입니다.',
				        });
					} else if (map.nullErrorMsg != null){
						Swal.fire({
	                        icon: 'error',
	                        text: map.nullErrorMsg + ' 내용을 채워주세요.',
	                    });
					} else {
						Swal.fire({
				            icon: 'error',
				            text: '잘못 된 접근입니다. 다시 시도해 주세요.',
				        });
					}
				} // End fn_success
			}) // End ajax
		}) // End modify_btn click event
	} // End fnModifyMemberInfo

	

	
	
/* ---------------------------------------------------------- fnLeave() ------------------------------ */
	// 회원 탈퇴
	function fnLeave() {
		$('#leave_btn').on('click', function(){
			 Swal.fire({
					text: '정말 탈퇴하시겠습니까?',
			        icon: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#D4D4D4',  // confirm
			        cancelButtonColor: '#D4D4D4',   // cancel
			        confirmButtonText: '탈퇴',
			        cancelButtonText: '취소'	
			     }).then((result) =>{
					if(result.isConfirmed) { // confirm이 false이면 return
						if(pw_result == true) { 
								Swal.fire({
						     //       icon: 'error',
						            title: '탈퇴되었습니다.',
						            text: 'NearBy를 이용해주셔서 감사합니다.',
						            timer: 300000,
						        });
								$('#form').attr('action', '/nearby/member/leaveMember/');
								$('#form').submit();
							} else if (pw_result == false || $('#pw').val()=='') { // pw_result == false 이면 return;
								Swal.fire({
						            icon: 'error',
						      //      title: '비밀번호 확인필요',
						            text: '비밀번호 확인 후 진행해 주세요',
						        });
							return;
						}
					} else { 
						return;
					} // End if
		     	})

		}) // End click event
	} // End fnLeave
	
/* ------------------------------------------------------------ fnCurrentPwCheck() ------------------------------------------------------------ */
	// 현재 비밀번호 확인 함수
	function fnCurrentPwCheck() {  // checkPassword
	    $('#password_check_btn').on('click',function(){ // TODO ajax로 select 결과 받아서 처리하기해야함.

			$.ajax({
				url : '/nearby/member/checkPassword',
				type : 'post',
				data : 'pw=' + $('#pw').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					let name = '${loginUser.name}';
					fnPwCheck(map);
					 if( map.selectResult > 0){
						Swal.fire({
							icon: 'success',
				//			title: '비밀번호 확인완료',
							text: name + '님의 비밀번호가 확인되었습니다.',
						})
						 pw_result = true;
		             } else if(map.selectResult == 0) {
						Swal.fire({
							icon: 'error',
					//		title: '비밀번호 재확인필요',
							text: name + '님의 비밀번호가 일치하지 않습니다. 다시시도해 주세요.',
						})
						 pw_result = false;
					 }
					 console.log(pw_result);
				}, // End Seuccess function
				error : function(xhr, ajaxOptions, thrownError) {
			       alert(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
		
	function fnPwCheck(map){
	    $('#pw').on('keyup', function(){
	        if($('#pw').val() == ''){
	            pw_result = false;
				return;
	        }else if(map.selectResult > 0){
	            pw_result = false;
				return;
	        }else{
	            pw_result = true;
	        }
	    });
	}// end fnPwCheck
	} // End fnCurrentPwCheck

	
</script>
	    
<script>
 
 // CSS용 Script

/* --------------------------------------- fnShowLeaveFormArea() --------------------------------------- */
	// 회원탈퇴 누르면 비밀번호 확인 area 보이기
	function fnShowLeaveFormArea() {
		$('.current_pw_check_box').toggleClass('show');
		$('#profile_result').removeClass('show');
		$('.hidden_box').toggleClass('hidden_class');
	} // fnShowLeaveFormArea
	
/* --------------------------------------- fnCloseBtn() --------------------------------------- */
	// close btn 누르면 사라지기
	function fnCloseBtn(){
		$('.current_pw_check_box').toggleClass('show');
		$('.hidden_box').toggleClass('hidden_class');
	}	

/* --------------------------------------- fnImageClose() --------------------------------------- */
	function fnImageClose(){
		$('.file_box').toggleClass('show');
		$('.hidden_box').toggleClass('hidden_class');
	}

/* --------------------------------------- fnShowBtnBox() --------------------------------------- */
	// file box 보이기
	function fnShowBtnBox() {
		$('.file_box').toggleClass('show');
		$('.hidden_box').toggleClass('hidden_class');
		$('#profile_result').addClass('show');
	}

/* ---------------------------------------	fnHomeLink()	------------------------------------------- */
	// 홈으로 가기
	function fnHomeLink() {
		$('#home_link').on('click', function(){
			location.href='/nearby/board/updateProfilePicture';
		}) // End home_btn click event
	} // End fnHomeBtn

	// 생년월일 삽입
	function fnBirth(){
		let year = '';
		year +=  '<option>년도</option>';
		for(let i=2007; i>=1907; i--){
		    year += '<option value="'+i+'">'+i+'</option>';
		}
		 $('#birthday').html(year);
		
		let month = '';
		month +=  '<option>월</option>';
		for(let i=1; i<=9; i++){
		    month += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		}
		for(let i=10; i<=12; i++){
		    month += '<option value="'+i+'">'+i+'</option>';
		}
		 $('#month').html(month);
		 
		 let day ='';
		 day += '<option>일</option>';
		 for(let i=1; i<=9; i++){
		     day += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		 }
		 for(let i=10; i<=31; i++){
		     day += '<option value="'+i+'">'+i+'</option>';
		 }
		  $('#day').html(day);	 
	}
</script>
</head>
<body>

   		<header class="header">
			<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
		</header>
 <!-- 레이아웃 header 삽입하기 -->
    <div class="profile_container"> <!-- 1 -->
	<div class="hidden_box"></div> <!-- hidden BOX -->
    	<c:if test="${loginUser.state == 0}">
	    	<!-- 회원탈퇴 -->
	    	<div class="leave_user_wrap">
	    		<input type="button" id="show_leave_btn_box" class="btn pointer" value="회원탈퇴하기" onclick="fnShowLeaveFormArea()">
	    			<!-- 탈퇴시, 비밀번호 인증 -->
                <div class="current_pw_check_box">
                	<div id="close_leave_btn_area">
	               		<i id="close_leave_area_icon" class="fas fa-times pointer" onclick="fnCloseBtn()"></i>   
                	</div>
                    <label for="pw">현재 비밀번호</label>
               		
               		
                    <div id="current_pw_box">
	                    <span class="space">
	                  	  <input type="text" id="pw" name="pw">
	                    </span>
	                    <span>
		                    <input type="button" value="확인하기" id="password_check_btn" class="pointer">
	                    </span>
                    </div>
		    		<input type="button" id="leave_btn" class="btn pointer" value="회원탈퇴하기">
                </div>
	    	</div>
	    	
	    	<p id='user_name_area'></p>
	    	<div id="profile_area">
				<div id="profile_result">
					<div id="p_img" style="width:100%;height:100%;" data-msg="이미지변경">
				
						<c:if test="${empty loginUser.profile.pSaved}">
							<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
						</c:if>
						<c:if test="${not empty loginUser.profile.pSaved}">
							<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" onclick="fnShowBtnBox()" class="pointer">
						</c:if>
					 
					</div>
				</div>
				<div class="content_box">
					<textarea rows="5" cols="35" placeholder="자신을 맘껏 표현해보세요" id="content" name="content"></textarea>
				</div>
				<!-- 첨부박스 -->
				<div class="file_box">
					<div id="close_file_box_icon_area">
						<!-- <i id="close_file_box_icon" class="fas fa-times pointer" onclick="fnShowBtnBox()"></i>    -->
						<i id="close_file_box_icon" class="fas fa-times pointer" onclick="fnImageClose()"></i>   
					</div>
					<label id="file_label" for="file"><i class="fas fa-photo-video"></i></label>
					<input type="file" id="file" class="pointer">
					<ul class="delete_update_form">
						<li><input type="button" value=' 사진변경 ' id="profile_insert_btn"  class="pointer"></li>
						<li><input type="button" value='사진초기화' id="delete_btn"  class="pointer"></li>
					</ul>
				</div>
	    	</div>
	 
	        <div class="join_form">
	        	<form id="form" method="post">
					<input type="hidden" value="${loginUser.mNo}" id="mNo" name="mNo">
	        	</form>
               <!-- 이름 -->
               <div class="input_box">
                   <label for="name">이름</label>
                   <span class="space">
                    <input type="text" id="name" name="name">
                   </span>
                   <span id="name_check"></span>
               </div>
	
               <!-- 번호 -->
               <div class="tel_box">
                   <label for="phone">핸드폰 번호</label>
                   <span class="space">
                    <input type="text" id="phone" name="phone" placeholder=" - 표시 없이 입력해주세요">
                   </span>
                   <span id="phone_check"></span>
               </div>
	               
               <!-- 생년월일 -->
               <div class="birth_box">
                   
                   <!-- 년도 -->
                   <label for="birthday">생년월일</label>
                   <select id="birthday" name="year"></select>

                   <!-- 월 -->
                   <select id="month" name="month">
                       <option>월</option>
                   </select>

                   <!-- 일 -->
                   <select id="day" name="day">
                       <option>일</option>
                   </select>
               </div>
	
               <!-- 성별 -->
               <div class="gender_box">
                   <p id="gender_box">성별</p>
                   <!-- 선택 안 함 -->
                   <input type="radio" name="gender" value="n" id="n" class="btns" checked>
                   <label id="n"  for="n">선택안함</label>

                   <!-- 남성 -->
                   <input type="radio" name="gender" value="m" id="male" class="btns">
                   <label id="m"  for="male">남성</label>
                   
                   <!-- 여성 -->
                   <input type="radio" name="gender" value="f" id="female">
                   <label id="f" for="female">여성</label>
               </div>
	
               <div class="btn_wrap">
                   <input type="button" id="modify_btn" class="btn btn-primary pointer" value="수정완료">                
               </div>                
	        </div>
    	</c:if>
    </div> <!-- End profile_container -->

 	<footer>
         <jsp:include page="/WEB-INF/views/layout/footer.jsp" flush="true" />
    </footer>

</body>
</html>