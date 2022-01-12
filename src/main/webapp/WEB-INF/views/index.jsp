<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NearBy - 내 주변의 빠른 소식통</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- jquery cookie 제어쿼리 쿠키  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js" integrity="sha512-aUhL2xOCrpLEuGD5f6tgHbLYEXRpYZ8G5yD+WlFrXrPy2IrWBlu6bih5C9H6qGsgqnU6mgx6KtU8TreHpASprw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
   * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
   }  
   a { text-decoration: none; color:black }
   @font-face {
     font-family: 'S-CoreDream-5Medium';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-5Medium.woff') format('woff');
     font-weight: normal;
     font-style: normal;
  }
  /* h1에 에스코어드림 M 적용하기*/
  .s_core_dream_m {
    font-family: 'S-CoreDream-5Medium';
  }
  @font-face {
    font-family: 'SBAggroL';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroL.woff') format('woff');
    font-weight: normal;
    font-style: normal;
  }
  /* p 태그 어그로체*/
  .aggroL {
 	font-family:  'SBAggroL';
  }
 
   @import url('https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css');
  /* 로그인 관련 p태그에 나눔스퀘어적용*/
  .nanum_square {
    font-family: 'NanumSquare';
   }

   .container {
      width: 100%;
      height: 100%;
      margin:   0 auto;
   }  
   .header_wrap {
      z-index: 5;
      position: fixed;
      top: 0;
      width:100%;
      height: 100px;
      background-color: rgba( 20, 20, 20, 0.9);
      display: flex;
   }
   .blur {
     opacity: 0.4;
     
   }
   .main {
         z-index: -1;
   }
   
   .main_box1 {
      width: 100%;
      height:400px;
      text-align: center;
      background-color: #fe565d;
      padding-bottom: 30px;
   }
   
   .main_box2 {
      width: 100%;
      height: 3000px;
      background-color: rgba(255, 250, 250, 0.8);
      margin: 0 auto;
      padding: 0 auto;
   }
   
   .main_box1 h1 {
      color: white;
      font-size: 56px;
      padding-top: 200px;
   }
   .btn {
      width: 140px;
      height: 40px;
      border-radius: 30px;
      border: none;
      font-size: 20px;
      cursor:pointer;   
   }
   .img_wrap {
      width: 100%;
      height: 1380px;
      display: flex;
   }
   .left_box {
      width: 50%;
      height: 100%;
      display: flex;
      text-align: center;
   }
   
   #img1 {
      margin: 260px auto;
	  width: 660px;
	  height: 924px;
   }
   
   #img2 {
     margin: 360px auto;
     width: 700px;
     height: 770px;
   }
   
   .right_box {
      width: 50%;
      height: 100%;
      display: inline-block;
      text-align: center;
   }
   #app_icon {
      width: 200px;
      margin-top: 500px;
   }
   
   .right_box h1 {
    margin-top: 80px;
    font-size: 40px;
    font-weight: 900;
   }
   .right_box p {
      margin-top: 10px;
      font-size: 30px;
      font-weight: 500;
   }

   #login_btn1 {
      margin: 30px auto;
      margin-right:2%;
      border-radius: 30px;
   }
   #login_btn1:hover {
      background-color: #fe565d;
      color: white;
   }
    #login_btn2 {
      background-color: rgb(43,26,27);
      color: white;
        margin-top: 40px;
      border-radius: 30px;
   }
   #login_btn2:hover {
      background-color: white;
      color: black;
   }
   #join_btn1 {
        margin-top: 44px;
        color: black;
   }
   #join_btn2 {
       margin-top: 40px;
       background-color: rgb(43,26,27);
       color: white;
       width: 200px;
   }
   #join_btn2:hover{
    background-color: white;
     color: black;
   }
   
   .main_box3 h1 {  padding-top: 120px;   }
   
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
      border: none;
      outline: none;
      width: 340px;
      height: 30px;
      line-height: 30px;
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
   
   /* sweet alert */
  .swal2-popup { padding: 0.5em; }
  .swal2-icon {
  	width: 4.5em;
  	height: 4.5em;
  }
   .swal2-styled { margin:  0.5em; }
   .swal2-styled.swal2-confirm { width: 100px; background-color: #d4d4d4;  }
   .swal2-styled.swal2-cancel {width: 100px;}
   .swal2-icon.swal2-warning { color: pink; border-color: pink;}
   .swal2-header{ height: 100px; }
   
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
   <div class="container">
     
     
     <!------------------------------------- header ------------------------------------->      
      
      <header class="header_wrap">
           <img id="logo" src="resources/image/logo_white.png" width="200px">
           <input type="button" value="로그인" id="login_btn1" class="btn login_btn">
      </header>
      
      <!------------------------------------- main --------------------------------------->
      
      <main class="main" >
         <div class="main_box1">
            <h1 class="s_core_dream_m">당신 근처에 일어나는 다양한 일들 알고싶어?</h1>
            <input type="button" value="시작하기" id="login_btn2" class="btn login_btn">
         </div>
      <div class="main_box2">
            <div class="img_wrap">
               <div class="left_box">
                  <img id="img1" src="resources/image/board1.png">
               </div>
               <div class="right_box">
                  <img id="app_icon" src="resources/image/app_icon.png">
                  <h1 class="s_core_dream_m">나도 모르는 사이 내 주변에 이런 일이? </h1>
                  <p class="aggroL">인싸들만 아는 정보들? 걱정 NO NO!</p>
                  <p class="aggroL">NEARBY 친구들이 알아서 알려줄거야</p>
               </div>
            </div>
            <div class="img_wrap">
               <div class="right_box">
                  <img id="app_icon" src="resources/image/app_icon.png">
                  <h1 class="s_core_dream_m">오늘 저녁 뭐 먹지? </h1>
                  <p class="aggroL">주변에 인기있는 핫플레이스 맛집 검색까지!</p>
                  <p class="aggroL">#홍대맛집 #분위기좋은바</p>
               </div>
               <div class="left_box">
                  <img id="img2" src="resources/image/board2.png">
               </div>

            </div>
                           
         </div>
         <div class="main_box1 main_box3">
            <h1 class="s_core_dream_m">지금 당장 NEARBY 시작하기</h1>
            <a href="/nearby/member/agreement"><input type="button" class="nanum_square btn" value="간편회원가입" id="join_btn2" class="btn join_btn"></a>
         </div>
      </main>
      <!---------------------------------------- 로그인 폼(숨김)---------------------------------------> 
             <form id="login_form" method="post" class="no" action="/nearby/member/login">
               <div>
                  <i id="close_login_btn" class="fas fa-times"></i>   
               </div>
               <div>
                  <img id="logo2" src="resources/image/logo_color.png" width="200px">
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
               		<!-- style visibility hidden : 스타일 가시성 숨김  -->
               		<input type="checkbox" id="checkRememberId" style="visibility: hidden;">
               		<!-- for="checkRememberId":체크기억아이디 class="idSavedCheck":아이지 저장된 수표" onclick="fnIdCheck": 클릭하면 확인한다. -->
               		<label for="checkRememberId" class="idSavedCheck" onclick="fnIdCheck()"><i class="far fa-check-circle"></i> 아이디 저장</label>
               	</div>
               
                      
                  <button class="nanum_square" id="login_submit">로그인</button>
                        <div id="move_area">
                        <a id="find_btn1" class="find_btn1" href="/nearby/member/findIdPw"><i class="fas fa-key"></i>아이디/비밀번호 찾기</a><br><br>
                        <a id="join_btn1" class="join_btn1" href="/nearby/member/agreement"><i class="fas fa-sign-in-alt"></i>회원가입 하러가기</a>
                    </div>
             </form>   
      
        
     <!------------------------------------- footer ---------------------------------------->
      <footer>
           <jsp:include page="/WEB-INF/views/layout/footer.jsp" flush="true" />
      </footer>
   </div>   
</body>
</html>