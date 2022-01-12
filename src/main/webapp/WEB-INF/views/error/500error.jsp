<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

	 * { 
	 font-family: 'Noto Sans KR', sans-serif;
	 padding: 0; margin: 0;
	 box-sizing: border-box;
	 background-color: #fafafa;
	}
	/* header 관련 */
   .header_wrap {
      z-index: 5;
      position: fixed;
      top: 0;
      width:100%;
      height: 100px;
      background-color: white;
      display: flex;
      margin-bottom: 30px;
   }
   .header_wrap a { background-color: white;}
   .header_btn {
      width: 140px;
      height: 40px;
      border-radius: 30px;
      border: none;
      font-size: 20px;
      margin-top: 30px;
      cursor:pointer;   
      right: 30px;
   }
   #header_logo {
	   	display: inline-block;
	   	margin-left: 40px;
	   	margin-top: 10px;
	   	background-color: white;
   }
    .title {
    	font-size: 24px;
    	text-align: center;
    	width: 500px;
    	margin: 30px auto;
     }
     .content {
     	font-size: 18px;
     	text-align: center;
    	width: 500px;
    	margin: 30px auto;
     }
    
	.img_wrap {
		width: 100%;
		margin: 160px auto 90px;
		text-align: center;
		}
	.img {
		width: 300px;
		margin: 0 auto;
	}
	.btn {
    	width: 140px;
        height: 40px;
        border-radius: 30px;
        border: none;
        font-size: 20px;
        cursor:pointer;   
   }
    #login_btn1 {
      margin: 30px auto;
      margin-right:2%;
      border-radius: 30px;
      background-color: #fe565d;
      color: white;
     }
   #login_btn1:hover {
      background-color: white;
      border: 1px solid #fe565d;
      color: black;
   }
  /* 로그인 폼 관련 */
  #login_form {    
       box-shadow: 10px 10px 20px rgba(30, 30, 30, 0.5);
       position:fixed;
       top: 140px;
       left: 200px;
       right: 200px;
       width: 600px;
       height: 670px;
       border-radius: 30px;
       border : 1px solid rgba(50,50,50,0.3);
       margin: 0 auto;
       margin-top: 20px;
       padding: 10px;
       text-align: center;
       background-color: white;
   }
   #login_form div, #login_form p, #login_form label,  #login_form img  { background-color:  white;}
   #login_form a { 
   	color: black;
   	text-decoration: none;
   }
   #close_login_btn {
      font-size: 20px;
      margin-left: 520px;
      margin-top: 16px;
      color: rgb(43,26,27);
   }   
   #close_login_btn:hover {
      color: #fe585c;
      cursor: pointer;
   }
   .input_wrap{
      margin: 0 auto;
   }
   .idSavedCheck { 
    display:inline-block;
    width:400px;
    height:50px;
   	  text-align: left;
   }
   #login_submit {
      margin-top: 30px;
      width: 400px;
      height: 50px;
      border-radius: 5px;
      border: none;
      background-color: #fe585c;
      font-size: 22px;
      color: white;   
   }
   #login_submit:hover {
      cursor: pointer;
   }  
   .see {
      display: block;
      width: 500px;
      height: 600px;
   }
   .no {
      display: none;
   }
   .input_box {
      border-radius: 5px;
      margin: 8px auto;
      margin-bottom: 30px;
      border: none;
      width: 400px;
      height: 40px;
      line-height: 20px;
      background-color: #e8f0fe;
   }
   .input_box > input {
      border-radius: 5px;
      border: none;
      outline: none;
      width: 390px;
      height: 37px;
      line-height: 25px;
      padding-left: 13px;
      margin-top: 8px;
      background-color: #e8f0fe;
   }
   .input_wrap > p{
      text-align: left;
      margin-left : 90px;
      font-size: 18px;
   }
   #logo2 {
      width: 280px;
      margin-top :40px;
      margin-bottom: 20px;      
   }
   #move_area {
     text-align: center;
     margin-top: 30px; 
   }
   #move_area i {
     display: inline-block;
     margin-right: 10px;
     color: rgb(50, 50, 50, 0.7);
   }
   #move_area p {
     color: rgb(50, 50, 50, 0.7);
   }
   #find_btn1:hover:nth-of-type(1)  {
     color: rgb(30, 30, 30);   
     font-weight: bold;
   }

   #join_btn1:hover  {
     color: rgb(30, 30, 30);   
     font-weight: bold;
   }	
	
  /* footer */
  .footer_wrap {
	   border-top:thin;
	   margin-top: 190px;
	   padding-bottom: 50px;
	   text-align: center;
	   font-weight: bold;
   }
   .footer_wrap p{
   		font-size: 12px;
   		font-weight: normal;
   }
   footer {
		margin-top : 200px;
   }
   
   
</style>
<script type="text/javascript">

$(document).ready(function(){
 fnLoginBtn();      // login 버튼 눌렀을 때 로그인 창 나타나기
 fnLogin();         // login 서브밋
 fnCloseLoginBtn();
 fnDisplayId();	// 아이디 표시
});
   

   // login 버튼 눌렀을 때 로그인 창 나타나기 / 배경 흐림효과
  function fnLoginBtn() {
   $('.login_btn').click( function() {
      $('#login_form').addClass('see').removeClass('no');
      $('.main').addClass('blur');
    });
 }
   
  // close_login_btn 눌렀을 때 로그인 창 사라지기 / 배경 흐림효과 삭제
  function fnCloseLoginBtn() {
   $('#close_login_btn').click( function() {
      $('#login_form').addClass('no').removeClass('see');
      $('.main').removeClass('blur');
    });
 }
  
  function fnIdCheck(){
     // 클릭했는데 핑크이면 그레이로 / 클릭했는데 그레이면 핑크로
  	if( 	$('.fa-check-circle').css('color', "#fe585c") == true ){
  		$('.fa-check-circle').css('color', "gray");
     }else {
  		   $('.fa-check-circle').css('color', '#fe585c'); 
     }
  	let rememberId = $.cookie('rememberId');
  	if (rememberId != '') {  // id 값 널아니고, 아이디 저장 기억하기 되어있으면 
  	 if( 	$('#checkRememberId').prop('checked') == true   ){
  		 
  		 $('#checkRememberId').prop('checked', true);
  			$('.fa-check-circle').css('color',"gray");
  	 } else {
  			$('#id').val(rememberId);
  			$('#checkRememberId').prop('checked', false);
  			$('.fa-check-circle').css('color',"#fe585c");
  	  }
  	}
  }
  
  
  
  // 아이디 표시
  function fnDisplayId(){
  	let rememberId = $.cookie('rememberId');
  	if (rememberId != '') {
  		$('#id').val(rememberId);
  		$('#checkRememberId').prop('checked', true);
  		$('.fa-check-circle').css('color',"#fe585c");
  	} else {
  		$('#checkRememberId').prop('checked', false);
  		$('.fa-check-circle').css('color',"gray");
  	} 
}
  
  
   // login 서브밋
 function fnLogin() {
    $("#login_form").submit(function(event){
       let regId = /^[a-zA-Z0-9_-]{4,}$/;                  // ID 정규식
       let regPw = /^[a-zA-Z0-9!@$%^&*()]{8,20}$/;         // PW 정규식
       if ( regId.test($('#id').val()) == false || regPw.test($('#pw').val()) == false){
          alert('아이디와 비밀번호의 형식이 올바르지 않습니다.');
          event.preventDefault();
          return false;
       }
       
    // 아이디 저장하기
			if ( $('#checkRememberId').is(':checked') ){  // 아이디 저장이 체크되어 있으면,
				$.cookie('rememberId', $('#id').val());  // 쿠키 rememberId 생성(아이디 저장) 
			} else {
				$.cookie('rememberId', '');  // 쿠키 rememberId 생성(빈 문자열 저장)
			}
			return true;
    });
 }
 
 
</script>
</head>
<body>
     <header class="header_wrap">
           <a href="/nearby/"><img id="header_logo" src="${pageContext.request.contextPath}/resources/image/logo_color.png" width="200px"></a>
   		   <input type="button" value="로그인" id="login_btn1" class="btn login_btn">     
     </header>
      
     <main>
		<div class="img_wrap">
	 		<a href="/nearby/"><img id="app_icon" src="${pageContext.request.contextPath}/resources/image/app_icon.png" class="img"></a>
		</div>
		<div>
			<div class="title">서비스 이용에 불편을 드려 죄송합니다.</div>
			<div class="content">빠른 시일 내에 복구하겠습니다.</div>
		</div>
	</main>
	
	
	      <!---------------------------------------- 로그인 폼(숨김)---------------------------------------> 
             <form id="login_form" method="post" class="no" action="/nearby/member/login">
               <div>
                  <i id="close_login_btn" class="fas fa-times"></i>   
               </div>
               <div>
                  <img id="logo2" src="${pageContext.request.contextPath}/resources/image/logo_color.png" width="200px">
               </div>
               <div class="input_wrap">
                  <p class="nanum_square">아이디</p>
                  <div class="input_box">
                     <input type="text" name="id" id="id">
                  </div>
               </div>   
               <div class="input_wrap">
                  <p class="nanum_square">비밀번호<p>
                  <div class="input_box">
                     <input type="text" name="pw" id="pw">
                  </div>
                  
               </div>     
               <div>
               		<input type="checkbox" id="checkRememberId" style="visibility: hidden;">
               		
               		<label for="checkRememberId" class="idSavedCheck" onclick="fnIdCheck()"><i class="far fa-check-circle"></i> 아이디 저장</label>
               	</div>
               
                      
                  <button class="nanum_square" id="login_submit">로그인</button>
                        <div id="move_area">
                        <a id="find_btn1" class="find_btn1" href="/nearby/member/findIdPw"><i class="fas fa-key"></i>아이디/비밀번호 찾기</a><br><br>
                        <a id="join_btn1" class="join_btn1" href="/nearby/member/memberJoin"><i class="fas fa-sign-in-alt"></i>회원가입 하러가기</a>
                    </div>
             </form>   
      
	
	  <footer>
           <jsp:include page="/WEB-INF/views/layout/footer.jsp" flush="true" />
      </footer>

</body>
</html>